// FinishPhaseCommand.swift

enum FinishPhaseCommand {
    static func execute(state: GameState) -> GameState {
        // logic
        return GameState(
            map: state.map,
            info: GameInfo(
                turn: state.info.turn + 1, maxTurns: state.info.maxTurns, phase: state.info.phase,
                availableCommand: state.info.availableCommand, savedCommand: state.info.savedCommand
            ),
            units: state.units, unitState: state.unitState
        )
    }
}
