import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check-task"
export default class extends Controller {
  connect() {
    console.log("connected")
  }


  toggle(event) {

    const status = event.target.checked; // Get the checked status of the checkbox

    console.log(event.target)
    console.log(this.element.action)
    console.log(status)

    fetch(this.element.action, { // Send PATCH request to the correct route
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({ status: event.target.checked }) // Send the updated status
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data);
    })
    // .catch(error => {
    //   console.error("Error:", error);
    // });
  }
}
