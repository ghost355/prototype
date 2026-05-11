enum Move {
    static func execute(
        state: GameState,
        originator: UnitID,
        recipient: UnitID,
        destination: GridCoordinate
    ) -> CommandResult {

        let cmdCost = 1

        // 1. Проверяем команды originator
        guard let hqCmd = state.unitState.commandState[originator],
            hqCmd.activated >= cmdCost
        else {
            return .failure(.unitNotFound, state)
        }

        // 2. Проверяем позиции и связь
        let isSelfMove = (originator == recipient)

        if !isSelfMove {
            // Штаб командует другим юнитом — нужна визуально-вербальная связь
            guard let hqPos = state.unitState.unitPosition[originator],
                let unitPos = state.unitState.unitPosition[recipient]
            else { return .failure(.unitNotFound, state) }
            guard !state.unitState.unitExposed.contains(recipient) else {
                return .failure(.unitExposed, state)
            }
            guard hqPos == unitPos else { return .failure(.noVisualVerbalContact, state) }

            // 3. Валидность клетки и соседство
            guard destination.row >= 0 && destination.row <= state.map.maxRow,
                destination.column >= state.map.minColumn
                    && destination.column <= state.map.maxColumn,
                unitPos.isAdjacent(with: destination)
            else { return .failure(.outOfBounds, state) }

        } else {
            // Штаб двигает сам себя — проверяем только его позицию и Exposed
            guard let unitPos = state.unitState.unitPosition[recipient] else {
                return .failure(.unitNotFound, state)
            }

            guard !state.unitState.unitExposed.contains(recipient) else {
                return .failure(.unitExposed, state)
            }

            // Валидность клетки и соседство
            guard destination.row >= 0 && destination.row <= state.map.maxRow,
                destination.column >= state.map.minColumn
                    && destination.column <= state.map.maxColumn,
                unitPos.isAdjacent(with: destination)
            else { return .failure(.outOfBounds, state) }
        }

        // 4. Выполняем перемещение и установку Exposed
        var newUnitPosition = state.unitState.unitPosition
        newUnitPosition[recipient] = destination
        var newExposed = state.unitState.unitExposed
        newExposed.insert(recipient)
        let newUnitState = state.unitState.copy(
            unitPosition: newUnitPosition, unitExposed: newExposed)

        // 5. Списываем команды
        var newCommandState = state.unitState.commandState
        newCommandState[originator] = hqCmd.copy(activated: hqCmd.activated - cmdCost)
        let finalUnitState = newUnitState.copy(commandState: newCommandState)

        return .success(state.copy(unitState: finalUnitState))
    }
}
