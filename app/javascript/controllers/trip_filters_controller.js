import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trip-filters"
export default class extends Controller {
  connect() {
  }

  submit(event) {
    event.preventDefault()
  
    const form = this.element
    const baseUrl = form.action
    const params = new URLSearchParams(new FormData(form))
  
    Turbo.visit(`${baseUrl}?${params.toString()}`, {
      frame: "trips",
      action: "advance"
    })
  }
}
