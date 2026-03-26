import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast-notification"
export default class extends Controller {
  static targets = [ "notice" ]

  connect() {
    this.show()
  }

  dismiss() {
    this.exit()
  }

  show() {
    // notification element is already in the dom but we need a css class to make it visible
    setTimeout(()=> { this.enter() }, 30) // entrance 

    setTimeout(()=> { this.exit() }, 9000) // exit    
  }

  enter() {
    this.element.style.bottom = '30px'
  }

  exit() {
    this.element.style.bottom = "-50%"
  }
}
