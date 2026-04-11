// controllers/radio_cards_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["radio", "content"]

  connect() {
    this.update()
  }

  select() {
    this.update()
  }

  update() {
    const method = this.radioTargets.find(r => r.checked)?.value
    
    this.contentTargets.forEach(el => {
      const isSelected = el.dataset.method == method

      el.classList.toggle("hidden", !isSelected)

      el.querySelectorAll("input").forEach(input => {
        if(isSelected) {
          input.removeAttribute("disabled")
        } else {
          input.setAttribute("disabled", "disabled")
        }
      })
    })
  }
}
