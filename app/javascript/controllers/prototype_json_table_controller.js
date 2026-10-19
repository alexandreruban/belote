import { Controller } from "@hotwired/stimulus"
import { cable } from "@hotwired/turbo-rails"

// PROTOTYPE, variant C: the table rendered in the browser from the JSON view the custom channel
// sends. This duplicates app/views/prototype/live_updates/_table.html.erb: two renderers to keep in step.
const SEATS = [ "north", "east", "south", "west" ]
const SYMBOLS = { S: "♠", H: "♥", D: "♦", C: "♣" }

const label = (card) => card.slice(0, -1) + SYMBOLS[card.slice(-1)]
const red = (card) => [ "H", "D" ].includes(card.slice(-1)) ? "red" : ""
const capitalize = (seat) => seat[0].toUpperCase() + seat.slice(1)

export default class extends Controller {
  static values = { seat: String }

  async connect() {
    this.subscription = await cable.subscribeTo({ channel: "Prototype::LiveUpdatesChannel" }, {
      received: (data) => data.error ? console.warn(data.error) : this.render(data)
    })
  }

  disconnect() {
    this.subscription?.unsubscribe()
  }

  play({ params: { card } }) {
    this.subscription.perform("play", { card })
  }

  render(view) {
    const i = SEATS.indexOf(view.seat)
    const around = { left: SEATS[(i + 1) % 4], partner: SEATS[(i + 2) % 4], right: SEATS[(i + 3) % 4] }

    const others = Object.entries(around).map(([ position, seat ]) => `
      <div class="other ${position} ${view.turn === seat ? "to-play" : ""}">
        <strong>${capitalize(seat)}</strong> ${position === "partner" ? "partner" : "opponent"}
        <span class="backs">${"🂠".repeat(view.card_counts[seat])}</span>
        ${view.tricks_won[seat]} ${view.tricks_won[seat] === 1 ? "Trick" : "Tricks"}
      </div>`).join("")

    const trick = view.trick.map(({ seat, card }) => `
      <span class="card ${red(card)} ${view.trick_winner === seat ? "winner" : ""}" data-card="${card}">
        ${label(card)}<small>${capitalize(seat)}</small>
      </span>`).join("")

    const hand = view.hand.map((card) => view.playable.includes(card)
      ? `<button class="card playable ${red(card)}" data-card="${card}" data-action="prototype-json-table#play" data-prototype-json-table-card-param="${card}">${label(card)}</button>`
      : `<span class="card ${red(card)}" data-card="${card}">${label(card)}</span>`).join("")

    const turn = view.turn === null ? "Deal over" : view.turn === view.seat ? "your turn" : `${capitalize(view.turn)} to play`

    this.element.innerHTML = `
      ${others}
      <div class="trick" data-prototype-public>${trick}</div>
      <div class="hand ${view.turn === view.seat ? "to-play" : ""}" data-hand-of="${view.seat}">${hand}</div>
      <p class="status">Move #${view.version} · ${turn}</p>
      <span hidden data-controller="prototype-latency" data-prototype-latency-stamp-value="${view.stamp}"></span>`
  }
}
