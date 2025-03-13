import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="service"
export default class extends Controller {
  connect() {

  }

  deleteService(event) {
    location.reload(); // Reloads the page after delete
  }
  refreshPage(event) {
    if (event.detail.success) {
      location.reload(); // Refresh the page after successful submission
    }
  }
}
