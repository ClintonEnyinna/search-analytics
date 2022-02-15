import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "formButton", "articles" ]

  search() {
    this.formButtonTarget.click()
  }

  updateArticles(e) {
    const [data, status, xhr] = e.detail

    this.articlesTarget.innerHTML = xhr.response
  }
}
