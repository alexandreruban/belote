import { Controller } from "@hotwired/stimulus"

// PROTOTYPE: gathers the stats each seat's iframe posts up, one row per seat.
const SEATS = [ "north", "east", "south", "west" ]

export default class extends Controller {
  static targets = [ "rows" ]

  connect() {
    this.bySeat = {}
    this.onMessage = (event) => {
      if (event.origin !== location.origin || event.data?.type !== "prototype:stats") return
      this.bySeat[event.data.seat] = event.data.stats
      this.render()
    }
    window.addEventListener("message", this.onMessage)
    this.render()
  }

  disconnect() {
    window.removeEventListener("message", this.onMessage)
  }

  render() {
    const kb = (bytes) => (bytes / 1024).toFixed(1)
    this.rowsTarget.innerHTML = SEATS.map((seat) => {
      const s = this.bySeat[seat]
      if (!s) return `<tr><td>${seat}</td><td colspan="10">loading…</td></tr>`
      const leaks = s.foreign.length
        ? `<span class="bad">${s.foreign.length}: ${s.foreign.join(" ")}</span>`
        : `<span class="good">0</span>`
      return `<tr><td>${seat}</td><td>${s.updates}</td><td>${s.last ?? "–"}</td><td>${s.median ?? "–"}</td>` +
        `<td>${s.p95 ?? "–"}</td><td>${s.max ?? "–"}</td><td>${s.frames}</td><td>${kb(s.bytes)}</td>` +
        `<td>${s.fetches}</td><td>${kb(s.fetchedBytes)}</td><td>${leaks}</td></tr>`
    }).join("")
  }
}
