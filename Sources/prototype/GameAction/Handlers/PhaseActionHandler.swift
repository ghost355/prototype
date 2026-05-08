// PhaseHandler.swift

enum PhaseHandler {
    static func execute(
        state: GameState,
        action: GameAction.Phase,
        drawing: ActionCardDrawing
    ) -> GameState {

        switch action {
        case .finish:
            return FinishPhaseCommand.execute(state: state)

        case .advance(let phase):
            return AdvancedPhaseCommand.execute(state: state, to: phase)
        }
    }
}
