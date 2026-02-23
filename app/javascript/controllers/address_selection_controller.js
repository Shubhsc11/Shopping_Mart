import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["submitBtn"]

    connect() {
        this.toggleButton()
    }

    toggleButton() {
        const selectedAddress = this.element.querySelector('input[name="delivery_detail_id"]:checked')
        if (selectedAddress) {
            this.submitBtnTarget.disabled = false
        } else {
            this.submitBtnTarget.disabled = true
        }
    }
}
