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
            var newInfo = state.info.copy(
                turn: newTurn,
                phase: newPhase
            )
            if newInfo.isOver {
                newInfo = newInfo.copy(isGameRunning: false)
            }
            return state.copy(info: newInfo)
        }

        // Иначе просто переходим на следующую фазу
        let nextPhase = state.info.missionType.phaseSequence[nextIndex]
        let newInfo = state.info.copy(phase: nextPhase)
        return state.copy(info: newInfo)
    }

    static func executePhase(state: GameState, drawing: ActionCardDrawing) -> GameState {
        switch state.info.phase {
        case .friendlyHQEvent: return FriendlyHQEvent.execute(state: state, drawing: drawing)
        case .defensiveEnemyActivity: return DefensiveEnemyActivity.execute(state: state, drawing: drawing)
        case .friendlyCommand: return FriendlyCommand.execute(state: state, drawing: drawing)
        case .offensivePatrolEnemyActivity: return OffensivePatrolEnemyActivity.execute(state: state, drawing: drawing)
        case .mutualCaptureRetreat: return MutualCaptureRetreat.execute(state: state, drawing: drawing)
        case .atCombatVehicleMovement: return AtCombatVehicleMovement.execute(state: state, drawing: drawing)
        case .mutualCombat: return MutualCombat.execute(state: state, drawing: drawing)
        case .cleanUp: return CleanUp.execute(state: state, drawing: drawing)
        }
    }
}
