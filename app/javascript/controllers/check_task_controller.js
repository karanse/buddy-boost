import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check-task"
export default class extends Controller {
  connect() {
    console.log("connected")
  }

  toggle(event) {
    console.log(event.target)
    console.log(this.element.action)
    console.log(event.target.value)


    fetch(this.element.action, {
      method: "PATCH",
      headers: {
        "Accept": "application/json"
      },
      body: {task: {'status': event.target.value}}
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      // window.location.reload()
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }
}
