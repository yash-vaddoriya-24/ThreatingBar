import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="service"
export default class extends Controller {
    refreshPage(event) {
        if (event.detail.success) {
            location.reload(); // Refresh the page after successful submission
        }
    }
}