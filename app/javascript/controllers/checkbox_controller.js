// app/javascript/controllers/checkbox_controller.js
import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js"

export default class extends Controller {
  static values = { url: String }

  update(event) {
    const params = new URLSearchParams()
    params.append("todo_item[completed]", event.target.checked)

    put(this.urlValue, { body: params, responseKind: "turbo-stream" })
  }
}
