// Infrastructure/ActionDeck.swift

final class ActionDeck: ActionCardDrawing {
    var drawPile: [ActionCard]
    var discardPile: [ActionCard]

    init() {
        let cards: [ActionCard] = loadJSON("actionDeck", as: [ActionCard].self, from: .module)
        drawPile = cards.shuffled()
        discardPile = []
    }

    func drawCards(count: Int) -> [ActionCard] {
        var result: [ActionCard] = []
        while result.count < count {
            guard let card = drawPile.popLast() else { return result }
            if card.id == 51 {
                drawPile += discardPile
                discardPile = []
                drawPile.shuffle()
                let middle = max(0, drawPile.count / 2)
                drawPile.insert(card, at: Int.random(in: 0..<middle))
                continue
            }
            result.append(card)
        }
        discardPile += result
        return result
    }
}
