import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateCardPositions()
    // Update positions when scrolling
    this.element.querySelectorAll('.wheel-rim-container').forEach(container => {
      container.addEventListener('scroll', () => this.updateCardPositions())
    })
  }

  updateCardPositions() {
    this.element.querySelectorAll('.wheel-rim').forEach(rim => {
      const container = rim.parentElement
      const containerCenter = container.offsetWidth / 2
      const containerRect = container.getBoundingClientRect()
      console.log("updating card positions")
      rim.querySelectorAll('.wheel-rim-card').forEach(card => {
        const cardRect = card.getBoundingClientRect()
        const cardCenter = (cardRect.left + cardRect.right) / 2
        const offsetFromCenter = (cardCenter - (containerRect.left + containerCenter)) / 20

        card.style.setProperty('--offset-from-center', offsetFromCenter)
      })
    })
  }
}
