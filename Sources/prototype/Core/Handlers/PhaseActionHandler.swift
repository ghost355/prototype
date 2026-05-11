// Handlers/PhaseActionHandler.swift

enum PhaseHandler {
    static func execute(
        state: GameState,
        action: GameAction.Phase,
        drawing: ActionCardDrawing
    ) -> GameState {

        switch action {
        case .finish:
            return FinishPhaseCommand.execute(state: state)
        }
    }
}
