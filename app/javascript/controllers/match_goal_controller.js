
// import { Controller } from 'stimulus'
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Hello from our first Stimulus controller");
  }
}
