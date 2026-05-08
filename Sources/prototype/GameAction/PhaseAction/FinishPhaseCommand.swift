// FinishPhaseCommand.swift

enum FinishPhaseCommand {
    static func execute(state: GameState) -> GameState {
        // logic
        let info = state.info.copy(turn: state.info.turn + 1)
        return state.copy(info: info)
    }
}
