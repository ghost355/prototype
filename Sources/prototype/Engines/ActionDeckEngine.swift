// Engines/ActionDeckEngine.swift

enum ActionDeckEngine {
    static func checkHqEvent(cards: [ActionCard]) -> AttemptResult {
        guard let card = cards.first else { return .failure }
        return card.hasIcon(.hqEvent) ? .success : .failure
    }
}
