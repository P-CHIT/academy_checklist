import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = [ "form", "name" ]

  submit(event){
    event.preventDefault();
    this.formTarget.requestSubmit();
    this.nameTarget.value = "";
  }
}
