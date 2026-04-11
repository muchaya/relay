import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
  // action: "click->modal#open"
  open(event) {
    const modal = document.getElementById(event.params.id)

    console.log("I am fired")
  
    modal.showModal()
  }

  // action: "click->modal#close"
  close({params: { id }}) {
    console.log(id)

    const modal = document.getElementById(id)

    modal.close()
  }

  // action: "keydown.esc->modal#closeEsc"
  closeEsc(event) {
    this.close(event)
  }

  // action: "keyup@window->modal#backdropClick"
  backdropClick(event) {
   // const modalId = event.currentTarget.dataset.modalId

   // const modal = document.getElementById(modalId)

   // if(modal.open) {
   //   return
   // }

   // if(!modal.contains(event.target)) {
   //   modal.close()
   // }
  }

  // action: "turbo-submit-end->modal#submitEnd"
  submitEnd(event) {
    if(event.detail.success) {
      const modalId = event.params.id
      
      this.close({ params: { id: modalId } })

    } 
  }

  // action: "click@document->modal#outsideClick keydown.esc@document->modal#closeEsc"
  outsideClick(event) {
    // 1. If the user clicked a link/button that is meant to OPEN a modal,
    // ignore this event. Let the 'open' method handle it.
    if (event.target.closest('[data-action*="modal#open"]')) {
      return
    }
  
    // 2. Otherwise, proceed with the "click away" logic
    document.querySelectorAll("dialog[open]").forEach((modal) => {
      // Check if the click was outside the modal's content wrapper
      if (modal.firstElementChild && !modal.firstElementChild.contains(event.target)) {
        modal.close()
      }
    })
  }
}
