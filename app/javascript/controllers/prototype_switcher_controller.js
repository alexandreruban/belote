import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// PROTOTYPE: cycles ?variant= with the arrows or the ← → keys.
export default class extends Controller {
  static values = { variants: Array, current: String }

  previous() {
    this.go(-1)
  }

  next() {
    this.go(1)
  }

  key(event) {
    if (event.target.closest("input, textarea, select, [contenteditable]")) return
    if (event.key === "ArrowLeft") this.previous()
    if (event.key === "ArrowRight") this.next()
  }

  go(offset) {
    const index = this.variantsValue.indexOf(this.currentValue)
    const variant = this.variantsValue[(index + offset + this.variantsValue.length) % this.variantsValue.length]
    const url = new URL(location.href)
    url.searchParams.set("variant", variant)
    Turbo.visit(url, { action: "replace" })
  }
}
