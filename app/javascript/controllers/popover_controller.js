import { Controller } from "@hotwired/stimulus"
import {computePosition} from '@floating-ui/dom'

// Connects to data-controller="popover"
export default class extends Controller {
  
  static targets = ['filtersContainer', 'popover']

  open(event) {
    this.closeOtherPopovers(event)
    const popoverId = event.params.id
    const popover = document.getElementById(popoverId)
    const container = this.filtersContainerTarget
    const containerRect = container.getBoundingClientRect()
  
    const width = containerRect.width * 0.98
    const left = containerRect.left + (containerRect.width - width) / 2
  
    popover.classList.remove("hidden")
    Object.assign(popover.style, {
      width: `${width}px`,
      left: `${left}px`,
      top: `${containerRect.bottom + window.scrollY + event.params.offset}px`
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
    this.popoverTargets.forEach((popover)=> {
      if(popover.id != event.currentTarget.dataset.popoverIdParam) {
        popover.classList.add('hidden')
      }
    })
  }

  closeAllPopovers() {
    this.popoverTargets.forEach((popover)=> {
      popover.classList.add('hidden')
    }
  )}
}
