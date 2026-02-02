import { Controller } from "@hotwired/stimulus"
import {computePosition} from '@floating-ui/dom'

// Connects to data-controller="popover"
export default class extends Controller {
  
  static targets = ['filtersContainer', 'popover']

  open(event) {
    this.closeOtherPopovers()

    const popoverId = event.params.id

    const reference = event.target

    const popover = document.getElementById(popoverId)

    const container = this.filtersContainerTarget

    const referenceRect = reference.getBoundingClientRect()
    const containerRect = container.getBoundingClientRect()

    console.log(window.innerWidth)

    const left = referenceRect.left - containerRect.left

    console.log(left)

    // Vertical: always below the search box
    const top = container.offsetHeight + 8

    popover.classList.remove("hidden")

    Object.assign(popover.style, {
      right: "36px",
      top: `${top}px`,
      left: "auto"
    })
  }

  closeOtherPopovers() {
    this.popoverTargets.forEach( (popover)=> {
      if(popover !== event.target) {
        popover.classList.add('hidden')
      }
    })
  }
}
