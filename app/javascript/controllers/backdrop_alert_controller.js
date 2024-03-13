import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check-task"
export default class extends Controller {
  static targets = ["backdrop"]
  connect() {
    console.log("connected")
  }


  toggle(event) {
    console.log("hello")
    this.backdropTarget.classList.add("d-none");

  }
}
