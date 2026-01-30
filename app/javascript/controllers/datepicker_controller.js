import { Controller } from "@hotwired/stimulus"
import AirDatepicker from 'air-datepicker'
import localeEn from 'air-datepicker/locale/en';

// Connects to data-controller="datepicker"
export default class extends Controller {

  static targets = ["datepicker"]

  connect() {
    this.picker = new AirDatepicker(this.datepickerTarget, {
      locale: localeEn,
      autoClose: true,
      navTitles: {
        days: 'MMMM yyyy'
      }
    })
  }

  show() {
    this.picker.show()
  }
}
