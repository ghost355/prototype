// GameAction/Phases/FriendlyHQEvent.swift

enum FriendlyHQEvent {
    static func execute(state: GameState, drawing: ActionCardDrawing) -> GameState {
        let eventHigherBound = 10 // во всех таблицах вроде 10

        guard state.info.turn > 1 else { return state.copy(debugMessage: "Пропуск 1 хода") }
        let eventCard = drawing.drawCards(count: 1)
        let result = ActionDeckEngine.checkHqEvent(cards: eventCard)
        guard result == .success else {
            return state.copy(debugMessage: "Нет события")
        }

        let randomCard = drawing.drawCards(count: 1)
        let eventNumber = randomCard.first?.randomNumber(for: eventHigherBound) ?? 0

        let eventName = "ЗАГЛУШКА"

        return state.copy(debugMessage: "Есть собыите номер \(eventNumber) Это \(eventName)")
    }
}
