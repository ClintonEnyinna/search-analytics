import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "formButton", "articles" ]

  search() {
    clearTimeout(this.debounce);

    this.debounce = setTimeout(() => {
      this.formButtonTarget.click()
    }, 270)
  }

  updateArticles(e) {
    const [data, status, xhr] = e.detail

    this.articlesTarget.innerHTML = xhr.response
  }
}
