import { Controller } from "@hotwired/stimulus"
import {computePosition} from '@floating-ui/dom'

// Connects to data-controller="popover"
export default class extends Controller {
  
  static targets = ['filtersContainer', 'popover']

  open(event) {
    this.closeOtherPopovers(event)

    const popoverId = event.params.id

    const reference = event.currentTarget

    const popover = document.getElementById(popoverId)

    const container = this.filtersContainerTarget

    const referenceRect = reference.getBoundingClientRect()
    const containerRect = container.getBoundingClientRect()

    const left = referenceRect.left - containerRect.left

    const top = `${referenceRect.bottom + window.scrollY + event.params.offset}px`

    popover.classList.remove("hidden")

    Object.assign(popover.style, {
      width: `${referenceRect.width}px`,
      left: left,
      top: top
    })
  }

  outsideClick(event) { 
    const isOutside = !event.target.closest('[data-popover-target="popover"]') &&
                      !event.target.closest('[data-action="click->popover#open"]')

   if(!isOutside) return
                      
    this.popoverTargets.forEach((popover) => {
      popover.classList.add('hidden')
    })
  }

  closeOtherPopovers(event) {
    this.popoverTargets.forEach( (popover)=> {
      if(popover.id != event.currentTarget.dataset.popoverIdParam) {
        popover.classList.add('hidden')
      }
    })
  }
}
