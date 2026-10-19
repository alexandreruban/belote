import { Controller } from "@hotwired/stimulus"

// PROTOTYPE: time from the server committing a move to this browser rendering it.
// Server and browser share a machine, so Date.now() - stamp compares like with like.
// Module state outlives the elements it watches: Turbo Streams replace them, morphing updates them.
const measured = new Set()
let pageLoad = true

export default class extends Controller {
  static values = { stamp: Number }

  stampValueChanged(stamp) {
    if (!stamp || measured.has(stamp)) return
    measured.add(stamp)

    if (pageLoad) {
      pageLoad = false // the page load itself, not a live update
      return
    }
    window.dispatchEvent(new CustomEvent("prototype:latency", { detail: { ms: Date.now() - stamp } }))
  }
}
