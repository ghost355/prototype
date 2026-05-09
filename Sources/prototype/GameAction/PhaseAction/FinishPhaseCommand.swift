// GameAction/PhaseAction/FinishPhaseCommand.swift

enum FinishPhaseCommand {
    static func execute(state: GameState) -> GameState {
        return PhaseProcessor.advance(state: state)
    }
}
