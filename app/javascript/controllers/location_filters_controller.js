import { Controller } from "@hotwired/stimulus"
import Fuse from "fuse.js"

// Connects to data-controller="location-filters"
export default class extends Controller {
  
  static targets = ["place", "leavingFromInput", "goingToInput", "goingToHint", "leavingFromHint"]

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

    // Where can I go from this location
    // Where could I have come from if I am at this location
    this.fromIndex = {}
    this.toIndex = {}

    routes.forEach(r => {
      ;(this.fromIndex[r.from] ||= []).push(r.to)
      ;(this.toIndex[r.to] ||= []).push(r.from)
    })

    this.placesFuse = new Fuse(this.places, {
      keys: ["name", "province", "locality"],
      threshold: 0.3
    })

    this.selectedFromId = null
    this.selectedToId = null
  }

  searchFrom(event) {
    const query = event.target.value.trim()
  
    this.#invalidateFromSelection()
  
    const places = this.selectedToId
      ? this.originsFor(this.selectedToId)
      : this.validOrigins()
  
    this.#renderSearchResults(
      this.#searchPlaces(query, places), "leaving-from-popover"
    )
  }

  leavingFromFocus() {
    const places = this.selectedToId
      ? this.originsFor(this.selectedToId)
      : this.validOrigins()
  
    if (!this.selectedToId) {
      this.leavingFromHintTarget.textContent = "Choose where you're departing from"
    } else {
      const toPlace = this.placeMap[this.selectedToId]
      this.leavingFromHintTarget.textContent = `${places.length} places can take you to ${toPlace.name}`
    }
  
    this.#renderSearchResults(places, "leaving-from-popover")
  }

  searchTo(event) {
    const query = event.target.value.trim()
  
    // user typed -> selection is no longer valid
    this.#invalidateToSelection()
  
    const places = this.selectedFromId
      ? this.destinationsFor(this.selectedFromId)
      : this.validDestinations()
  
    this.#renderSearchResults(
      this.#searchPlaces(query, places), "going-to-popover"
    )
  }

  goingToFocus() {
    const places = this.selectedFromId
      ? this.destinationsFor(this.selectedFromId)
      : this.validDestinations()
  
    if (!this.selectedFromId) {
      this.goingToHintTarget.textContent = "Choose where you're going to"
    } else {
      const fromPlace = this.placeMap[this.selectedFromId]
      this.goingToHintTarget.textContent = `${places.length} destinations from ${fromPlace.name}`
    }
  
    this.#renderSearchResults(places, "going-to-popover")
  } 

  #searchPlaces(query, places) {
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
    const placeName = result.querySelector("[data-name]")?.textContent.trim()
  
    if (popover.id === "leaving-from-popover") {
      this.selectedFromId = placeId
      this.leavingFromInputTarget.value = placeName
    } else {
      this.selectedToId = placeId
      this.goingToInputTarget.value = placeName
    }
  
    this.dispatch("place-selected")
  }

  allowedOrigins() {
    // Leaving From input
    // Constrained ONLY if Going To is selected
    return this.selectedToId
      ? this.originsFor(this.selectedToId)
      : this.validOrigins()
  }

  allowedDestinations() {
    // Going To input
    // Constrained ONLY if Leaving From is selected
    return this.selectedFromId
      ? this.destinationsFor(this.selectedFromId)
      : this.validDestinations()
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

  #invalidateFromSelection() {
    this.selectedFromId = null
  }
  
  #invalidateToSelection() {
    this.selectedToId = null
  }

  #renderSearchResults(places, popoverId) {
    const popover = document.getElementById(popoverId)
    const searchBox = popover.querySelector(".search-results")
    searchBox.innerHTML = ""
  
    places.forEach(place => {
      const template = document.getElementById("place").content.cloneNode(true)

      template.querySelector("[data-location-filters-place-id-param]").dataset.placeId = place.id
      template.querySelector("[data-name]").textContent = place.name
      template.querySelector("[data-type]").textContent = place.locality
      template.querySelector("[data-province]").textContent = `${place.province},`
  
      searchBox.appendChild(template)
    })
  }
}
