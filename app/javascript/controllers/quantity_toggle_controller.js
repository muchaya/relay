// app/javascript/controllers/quantity_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value", "input"]
  static values = {
    min: { type: Number, default: 1 },
    max: Number
  }

  connect() {
    this.count = this.inputTarget
      ? parseInt(this.inputTarget.value) || this.minValue
      : this.minValue

    this.update()
  }

  increment() {
    if (this.maxValue && this.count >= this.maxValue) return
    this.count++
    this.update()
  }

  decrement() {
    if (this.count <= this.minValue) return
    this.count--
    this.update()
  }

  update() {
    this.valueTarget.textContent = this.count

    if (this.inputTarget) {
      this.inputTarget.value = this.count
    }
  }
}
