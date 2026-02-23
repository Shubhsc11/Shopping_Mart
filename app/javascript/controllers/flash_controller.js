import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    // Set a timeout to hide the element after 5 seconds
    setTimeout(() => {
      this.hide()
    }, 3000)
  }

  hide() {
    // Use Bootstrap's dismissal process if possible, or manual fade-out
    this.element.classList.remove("show")

    // Completely remove the element after the transition (Bootstrap alert fade is 150ms)
    setTimeout(() => {
      this.element.remove()
    }, 200)
  }
}
