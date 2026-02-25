import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["dynamicSelect"]
    static values = { url: String }

    change(event) {
        const categoryId = event.target.value
        if (!categoryId) {
            this.clearSubcategories()
            return
        }

        const url = `${this.urlValue}?category_id=${categoryId}`

        fetch(url)
            .then(response => response.json())
            .then(data => {
                this.updateSubcategories(data)
            })
    }

    updateSubcategories(data) {
        const select = this.dynamicSelectTarget
        select.innerHTML = '<option value="">Select Subcategory</option>'

        data.forEach(item => {
            const option = document.createElement("option")
            option.value = item.id
            option.text = item.subcategory_name
            select.appendChild(option)
        })
    }

    clearSubcategories() {
        this.dynamicSelectTarget.innerHTML = '<option value="">Select Subcategory</option>'
    }
}
