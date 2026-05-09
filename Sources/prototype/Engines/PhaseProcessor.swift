/// Engines/PhaseProcessor.swift
enum PhaseProcessor {
    static func advance(state: GameState) -> GameState {
        let currentPhase = state.info.phase
        guard let currentIndex = state.info.missionType.phaseSequence.firstIndex(of: currentPhase) else {
            return state
        }

        let nextIndex = currentIndex + 1

        // Если это была последняя фаза – начинаем новый ход
        if nextIndex >= state.info.missionType.phaseSequence.count {
            let newTurn = state.info.turn + 1
            let newPhase = state.info.missionType.phaseSequence.first ?? .friendlyCommand
            let newUnitState = state.unitState.copy(unitExposed: [])
            let newInfo = state.info.copy(
                turn: newTurn,
                phase: newPhase
            )
            return state.copy(info: newInfo, unitState: newUnitState)
        }

        // Иначе просто переходим на следующую фазу
        let nextPhase = state.info.missionType.phaseSequence[nextIndex]
        let newInfo = state.info.copy(phase: nextPhase)
        return state.copy(info: newInfo)
    }
}
