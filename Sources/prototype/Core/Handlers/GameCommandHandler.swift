// Handlers/GameCommandHandler.swift

enum GameCommandHandler {
    static func execute(
        state: GameState,
        action: GameAction.Game,
        drawing _: ActionCardDrawing
    ) -> GameState {
        switch action {
        case .exit:
            return ExitCommand.execute(state: state)
        }
    }
}
