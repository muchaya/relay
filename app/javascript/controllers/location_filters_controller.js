import { Controller } from "@hotwired/stimulus"
import Fuse from "fuse.js"

// Connects to data-controller="location-filters"
export default class extends Controller {
  
  static targets = ["place"]

  static values = {
    places: Array
  }
  
  connect() {
    this.fuse = new Fuse(this.placesValue, {
      keys: ["name", "province"],
      threshold: 0.4 
    })
  }

  search(event) {
    const query = event.target.value

    if(query.length === 0)  return

    const results = query ? this.fuse.search(query).map(r => r.item) : this.locationsValue
    this.#renderResults(results)
  }

  #renderResults(places) {
    const popover = document.getElementById("leaving-from-popover")
    popover.innerHTML = ""
  
    places.forEach(place => {
      
      const template = document.getElementById("place").content.cloneNode(true)
      
      template.querySelector("[data-name]").textContent = place.name
      template.querySelector("[data-type]").textContent = place.type
      template.querySelector("[data-province]").textContent = `${place.province},`
  
      popover.appendChild(template)
    })
  }
}


