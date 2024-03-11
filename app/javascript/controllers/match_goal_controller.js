
// import { Controller } from 'stimulus'
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Match-goal controller connected");
    console.log(document.querySelector('meta[name="csrf-token"]').getAttribute('content'))
  }

  match(event) {
    console.log("Match me button clicked");
    event.preventDefault()
    console.log(this.element)
     // Access the value of data-your-controller-goal-id-value attribute

    // Send an AJAX request to Rails backend to perform the matching logic
    fetch(this.element.action, {
      method: "POST",
      headers: {
        "Accept": "application/json"
        // "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: new FormData(this.element)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
    })
    // .catch(error => {
    //   console.error("Error:", error);
    // });
  }
}
