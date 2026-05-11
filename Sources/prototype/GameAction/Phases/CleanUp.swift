// GameAction/Phases/CleanUp.swift

enum CleanUp {
    static func execute(state: GameState, drawing: ActionCardDrawing) -> GameState {
        let clearedExposed = state.unitState.copy(unitExposed: [])

        let allUnitsOnTopRow = state.unitState.unitPosition.values.allSatisfy { $0.row == 3 }

        if state.info.turn == state.info.maxTurns {
            if !allUnitsOnTopRow {
                // На последнем ходе не выполнено условие победы
                return state.copy(
                    info: state.info.copy(isGameRunning: false),
                    unitState: clearedExposed,
                    debugMessage: "Поражение! Не все юниты достигли 3-го ряда к 5-му ходу.")
            } else {
                // Победа
                return state.copy(
                    info: state.info.copy(isGameRunning: false),
                    unitState: clearedExposed,
                    debugMessage: "Победа, все подразделения достигли ряда назначения")
            }
        }
        // Если не 5-й ход — просто снимаем Exposed
        return state
    }
}
