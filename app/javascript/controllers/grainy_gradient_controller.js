import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="grainy-gradient"
export default class extends Controller {
  connect() {
    const tilesEl = document.querySelector('.bg_tiles')
    const gradientContainer = document.querySelector('.grainy-gradient')

    window.addEventListener('scroll', () => {
      const rect = gradientContainer.getBoundingClientRect()
      const viewportHeight = window.innerHeight
      
      // How far through the viewport the container has scrolled (0 to 1)
      const progress = 1 - (rect.top / viewportHeight)
      const clamped = Math.max(0, Math.min(1, progress))
      
      const scale = 1 + (clamped * 0.2)
      tilesEl.style.transform = `translate3d(0px, 0px, 0px) scale(${scale}, 1)`
    })
  }
}
