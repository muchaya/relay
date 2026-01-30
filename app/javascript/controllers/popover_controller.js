import { Controller } from "@hotwired/stimulus"
import {computePosition} from '@floating-ui/dom'

// Connects to data-controller="popover"
export default class extends Controller {
  connect() {
    computePosition(button, tooltip, {
      placement: 'bottom',
    }).then(({x, y}) => {
      Object.assign(tooltip.style, {
        left: `${x}px`,
        top: `${y}px`,
      });
    });
  }
}
