import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="radio-accordion"
export default class extends Controller {
  static targets = ["trigger", "content"]

  toggle(event) {
    event.stopPropagation()

    const label = event.target.closest('label')
    const radio = label.querySelector('[data-radio-accordion-target="trigger"]')
    
    const clickedIndex = this.triggerTargets.indexOf(radio)
    
    this.#hideAllContent()
    
    this.contentTargets[clickedIndex].classList.remove('hidden')
  }

  #hideAllContent() {
    this.contentTargets.forEach(content => {
      content.classList.add('hidden')
    })
  }
}
