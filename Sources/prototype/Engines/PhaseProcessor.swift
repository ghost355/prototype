/// Engines/PhaseProcessor.swift
enum PhaseProcessor {
    static func executePhase(
        state: GameState,
        drawing: ActionCardDrawing,
        phaseIndex: Int
    ) -> GameState {
        guard phaseIndex < state.phaseDescriptors.count else { return state }
        let descriptor = state.phaseDescriptors[phaseIndex]
        return descriptor.execute(state, drawing)
    }

    static func nextPhase(
        state: GameState,
        currentIndex: Int
    ) -> GameState {
        let totalPhases = state.phaseDescriptors.count
        if currentIndex + 1 >= totalPhases {
            // Новый ход: turn увеличивается
            let newTurn = state.info.turn + 1
            var newInfo = state.info.copy(turn: newTurn)
            if newInfo.isOver {
                newInfo = newInfo.copy(isGameRunning: false)
            }
            return state.copy(info: newInfo)
        } else {
            return state
        }
    }
}
