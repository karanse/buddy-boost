
// import { Controller } from 'stimulus'
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Match-goal controller connected");
  }

  match(event) {
    console.log("Match me button clicked");
    event.preventDefault()
    console.log(this.element.action)
     // Access the value of data-your-controller-goal-id-value attribute
    //  console.log(this.element.getElementById("match_goal"))
    // Send an AJAX request to Rails backend to perform the matching logic
    fetch(this.element.action, {
      method: "POST",
      headers: {
        "Accept": "application/json"
      },
      body: new FormData(this.element)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      window.location.reload()
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }
}
