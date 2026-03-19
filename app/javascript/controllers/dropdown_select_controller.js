import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["options", "selected", "input", "label", "amount"]

  toggle() {
    this.optionsTarget.classList.toggle("hidden")
    this.selectedTarget.classList.toggle("hidden")
  }

  select(event) {
    const item = event.currentTarget
    const value = item.dataset.value
    const label = item.dataset.label
    const amount = item.dataset.amount

    // update hidden input
    this.inputTarget.value = value

    // update visible label and amount
    if (this.hasLabelTarget) this.labelTarget.textContent = label
    if (this.hasAmountTarget) this.amountTarget.textContent = amount

    // close dropdown
    this.optionsTarget.classList.add("hidden")
    this.selectedTarget.classList.remove("hidden")
  }
}