import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password-toggle"
export default class extends Controller {
  static targets = [ "block", "input", "show", "hide" ]

  input() {
    const isToggleable = parseInt(this.inputTarget.value.length) > 0

    this.blockTarget.classList.toggle("hidden", !isToggleable)
  }
  
  toggle() {
    const isPassword = this.inputTarget.type === "password"
    
    this.inputTarget.type = isPassword ? "text" : "password"
    
    this.showTarget.classList.toggle("hidden", isPassword)
    this.hideTarget.classList.toggle("hidden", !isPassword)
  }
}
