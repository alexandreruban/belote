import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// PROTOTYPE: cycles ?variant= with the arrows or the ← → keys, and ?scenario= with ↑ ↓ when the page has scenarios.
export default class extends Controller {
  static values = { variants: Array, current: String, scenarios: Array, scenario: String }

  previous() {
    this.go(-1)
  }

  next() {
    this.go(1)
  }

  pick(event) {
    this.visit("scenario", event.target.value)
  }

  key(event) {
    if (event.target.closest("input, textarea, select, [contenteditable]")) return
    if (event.metaKey || event.ctrlKey || event.altKey) return
    if (event.key === "ArrowLeft") this.previous()
    if (event.key === "ArrowRight") this.next()
    if (this.scenariosValue.length && ["ArrowUp", "ArrowDown"].includes(event.key)) {
      event.preventDefault()
      this.visit("scenario", this.cycle(this.scenariosValue, this.scenarioValue, event.key === "ArrowUp" ? -1 : 1))
    }
  }

  go(offset) {
    this.visit("variant", this.cycle(this.variantsValue, this.currentValue, offset))
  }

  cycle(list, current, offset) {
    return list[(list.indexOf(current) + offset + list.length) % list.length]
  }

  visit(param, value) {
    const url = new URL(location.href)
    url.searchParams.set(param, value)
    Turbo.visit(url, { action: "replace" })
  }
}
