import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  remove() {
    this.element.remove()
  }

  removeParent() {
    this.element.parentElement.remove()
  }

  removeClass() {
    this.element.classList.remove(this.element.dataset.class);
  }
}
