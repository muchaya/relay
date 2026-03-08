import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="day-tabs"
export default class extends Controller {
  static targets = ["tab"]
  static classes = [ "active", "inactive" ]

  select(event) {
    const clicked = event.currentTarget

    this.tabTargets.forEach((tab) => {
      tab.classList.remove(...this.activeClasses)
      tab.classList.add(...this.inactiveClasses)
    })

    clicked.classList.remove(...this.inactiveClasses)
    clicked.classList.add(...this.activeClasses)
  }
}
