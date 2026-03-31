import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["controlsContainer", "controls", "segment", "segmentContent" ];

  connect() {
    this.controlsTarget.classList.add('transitionable') // only allow transitions with css when DOM is loaded

    const defaultSegment = this.segmentTargets[0]

    this.highlight(defaultSegment)
  }

  select(event) {
    const segmentIndex = this.segmentTargets.indexOf(event.target)

    this.updateSegments(event);
    this.toggleSegmentContent(segmentIndex)
  }

  updateSegments(event) {

    const selectedSegment = event.currentTarget
    
    this.segmentTargets.forEach( (segment) => {
      if (segment === selectedSegment ) {
        segment.parentElement.classList.add('selected-segment')
      } else {
        segment.parentElement.classList.remove('selected-segment')
      }
    })

    this.highlight(selectedSegment)
  }

  highlight(segment) {
    const { offsetWidth, offsetLeft } = segment.parentElement

    this.controlsContainerTarget.style.setProperty("--highlight-width", `${offsetWidth}px`);
    this.controlsContainerTarget.style.setProperty("--highlight-x-pos", `${offsetLeft}px`); 
  }

  toggleSegmentContent(segmentIndex) {
    this.segmentContentTargets.forEach((target) => {
      target.classList.add("hidden");
    })

    const showingContent = this.segmentContentTargets[segmentIndex]

    if(showingContent) {
      showingContent.classList.remove('hidden')
    }
  }
}
