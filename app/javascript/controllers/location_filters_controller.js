import { Controller } from "@hotwired/stimulus"
import Fuse from "fuse.js"

// Connects to data-controller="location-filters"
export default class extends Controller {
  
  static targets = ["place", "leavingFromInput", "goingToInput"]

  static values = {
    routesGraph: Object 
  }
  
  connect() {
    const { places, routes } = this.routesGraphValue

    this.places = places
    this.routes = routes

    // Place lookup
    this.placeMap = Object.fromEntries(
      places.map(p => [p.id, p])
    )

    // Graph indexes
    // Where can I go from this location
    // Where could I have come from if I am at this location
    this.fromIndex = {}
    this.toIndex = {}

    routes.forEach(r => {
      ;(this.fromIndex[r.from] ||= []).push(r.to)
      ;(this.toIndex[r.to] ||= []).push(r.from)
    })

    // Global Fuse (all places)
    this.placesFuse = new Fuse(this.places, {
      keys: ["name", "province", "locality"],
      threshold: 0.3
    })

    // State
    this.selectedFromId = null
    this.selectedToId = null
  }

  searchFrom(event) {
    const query = event.target.value.trim()

    const places = this.selectedToId
    ? this.originsFor(this.selectedToId)
    : this.validOrigins()

    this.#renderSearchResults(
      this.searchPlaces(query, places), "leaving-from-popover"
    )
  }

  searchTo(event) {
    const query = event.target.value.trim()

    const places = this.selectedFromId
      ? this.destinationsFor(this.selectedFromId)
      : this.validDestinations()

    this.#renderSearchResults(
      this.searchPlaces(query, places), "going-to-popover"
    )
  }

  searchPlaces(query, places) {
    if (!query) return places

    const fuse = new Fuse(places, {
      keys: ["name", "province", "locality"],
      threshold: 0.3
    })

    return fuse.search(query).map(r => r.item)
  }

  select(event) {
    const result = event.currentTarget
    const popover = result.closest(".tooltip")
  
    const placeId = result.dataset.placeId
    const placeName =
      result.querySelector("[data-name]")?.textContent.trim()
  
    if (popover.id === "leaving-from-popover") {
      this.selectedFromId = placeId
      this.leavingFromInputTarget.value = placeName
    } else {
      this.selectedToId = placeId
      this.goingToInputTarget.value = placeName
    }
  
    this.dispatch("place-selected")
  }

  destinationsFor(fromId) {
    return (this.fromIndex[fromId] || []).map(id => this.placeMap[id])
  }

  originsFor(toId) {
    return (this.toIndex[toId] || []).map(id => this.placeMap[id])
  }

  validDestinations() {
    return Object.keys(this.toIndex).map(id => this.placeMap[id])
  }

  validOrigins() {
    return Object.keys(this.fromIndex).map(id => this.placeMap[id])
  }

  #renderSearchResults(places, popoverId) {
    const popover = document.getElementById(popoverId)
    popover.innerHTML = ""
  
    places.forEach(place => {
      const template = document.getElementById("place").content.cloneNode(true)

      template.querySelector("[data-location-filters-place-id-param]").dataset.placeId = place.id
      template.querySelector("[data-name]").textContent = place.name
      template.querySelector("[data-type]").textContent = place.locality
      template.querySelector("[data-province]").textContent = `${place.province},`
  
      popover.appendChild(template)
    })
  }
}
