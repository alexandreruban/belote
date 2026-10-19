import { Controller } from "@hotwired/stimulus"
import { cable } from "@hotwired/turbo-rails"

// PROTOTYPE: what reached this browser, how fast, and whether any of it was another Player's card.
// A card is "from another hand" when a frame names it but, once the frame has rendered,
// it is neither in this seat's hand nor on the table.
const CARD = /"((?:7|8|9|10|J|Q|K|A)[SHDC])"/g

export default class extends Controller {
  static targets = [ "summary", "log", "drop" ]
  static values = { seat: String }

  connect() {
    this.latencies = []
    this.frames = this.bytes = this.fetches = this.fetchedBytes = 0
    this.known = new Set()
    this.foreign = new Set()
    this.log = []

    this.onWire = (event) => this.received(event.detail)
    this.onLatency = (event) => this.measured(event.detail.ms)
    this.onFetch = (event) => this.fetched(event.detail.fetchResponse)
    window.addEventListener("prototype:wire", this.onWire)
    window.addEventListener("prototype:latency", this.onLatency)
    document.addEventListener("turbo:before-fetch-response", this.onFetch)
    this.render()
  }

  disconnect() {
    window.removeEventListener("prototype:wire", this.onWire)
    window.removeEventListener("prototype:latency", this.onLatency)
    document.removeEventListener("turbo:before-fetch-response", this.onFetch)
  }

  async dropConnection() {
    const consumer = await cable.getConsumer()
    consumer.disconnect()
    this.dropTarget.disabled = true
    this.dropTarget.textContent = "Disconnected…"
    setTimeout(() => {
      consumer.connect()
      this.dropTarget.disabled = false
      this.dropTarget.textContent = "Drop connection for 5s"
    }, 5000)
  }

  received({ bytes, frame }) {
    this.frames++
    this.bytes += bytes

    const text = typeof frame.message === "string" ? frame.message : JSON.stringify(frame.message)
    const entry = { channel: JSON.parse(frame.identifier).channel, bytes, text, leaked: [] }
    this.log.unshift(entry)
    this.log.length = Math.min(this.log.length, 8)

    const cards = new Set([ ...text.matchAll(CARD) ].map((match) => match[1]))
    setTimeout(() => {
      this.learnVisibleCards()
      entry.leaked = [ ...cards ].filter((card) => !this.known.has(card))
      entry.leaked.forEach((card) => this.foreign.add(card))
      this.render()
    }, 100)
    this.render()
  }

  measured(ms) {
    this.latencies.push(ms)
    this.render()
  }

  fetched(fetchResponse) {
    this.fetches++
    fetchResponse.response.clone().text().then((body) => {
      this.fetchedBytes += new Blob([ body ]).size
      this.render()
    })
  }

  learnVisibleCards() {
    const mine = document.querySelectorAll(`[data-hand-of="${this.seatValue}"] [data-card]`)
    if (mine.length === 8) this.known.clear() // a fresh Deal
    mine.forEach((card) => this.known.add(card.dataset.card))
    document.querySelectorAll("[data-prototype-public] [data-card]").forEach((card) => this.known.add(card.dataset.card))
  }

  get stats() {
    const sorted = [ ...this.latencies ].sort((a, b) => a - b)
    const at = (p) => sorted.length ? sorted[Math.min(sorted.length - 1, Math.floor(p * sorted.length))] : null
    return {
      updates: sorted.length,
      last: this.latencies.at(-1) ?? null,
      median: at(0.5),
      p95: at(0.95),
      max: sorted.at(-1) ?? null,
      frames: this.frames,
      bytes: this.bytes,
      fetches: this.fetches,
      fetchedBytes: this.fetchedBytes,
      foreign: [ ...this.foreign ]
    }
  }

  render() {
    const stats = this.stats
    const kb = (bytes) => (bytes / 1024).toFixed(1)
    const leaks = stats.foreign.length
      ? `<span class="bad">${stats.foreign.length} cards from other hands received: ${stats.foreign.join(" ")}</span>`
      : `<span class="good">no card from another hand received</span>`
    this.summaryTarget.innerHTML =
      `Latency last ${stats.last ?? "–"} ms · median ${stats.median ?? "–"} · p95 ${stats.p95 ?? "–"} (${stats.updates} updates)<br>` +
      `Cable ${stats.frames} frames, ${kb(stats.bytes)} KB · HTTP ${stats.fetches} fetches, ${kb(stats.fetchedBytes)} KB · ${leaks}`

    this.logTarget.replaceChildren(...this.log.map((entry) => {
      const item = document.createElement("li")
      item.textContent = `${entry.channel}, ${entry.bytes} B: ${entry.text.slice(0, 600)}`
      if (entry.leaked.length) {
        const leak = document.createElement("div")
        leak.className = "leak"
        leak.textContent = `⚠ cards from other hands: ${entry.leaked.join(" ")}`
        item.prepend(leak)
      }
      return item
    }))

    window.parent.postMessage({ type: "prototype:stats", seat: this.seatValue, stats }, location.origin)
  }
}
