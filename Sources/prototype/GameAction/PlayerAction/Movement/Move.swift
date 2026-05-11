enum Move {
    static func execute(
        state: GameState,
        originator: UnitID,
        recipient: UnitID,
        destination: GridCoordinate
    ) -> GameState {
        
        let cmdCost = 1
        
        // 1. Проверяем команды originator
        guard let hqCmd = state.unitState.commandState[originator],
              hqCmd.activated >= cmdCost else {
            return state
        }
        
        // 2. Проверяем позиции и связь
        let isSelfMove = (originator == recipient)
        
        if !isSelfMove {
            // Штаб командует другим юнитом — нужна визуально-вербальная связь
            guard let hqPos = state.unitState.unitPosition[originator] else { return state }
            guard let unitPos = state.unitState.unitPosition[recipient],
                  !state.unitState.unitExposed.contains(recipient),
                  hqPos == unitPos else { return state }
            
            // 3. Валидность клетки и соседство
            guard destination.row >= 0 && destination.row <= state.map.maxRow,
                  destination.column >= state.map.minColumn && destination.column <= state.map.maxColumn,
                  unitPos.isAdjacent(with: destination) else { return state }
            
        } else {
            // Штаб двигает сам себя — проверяем только его позицию и Exposed
            guard let unitPos = state.unitState.unitPosition[recipient],
                  !state.unitState.unitExposed.contains(recipient) else { return state }
            
            // Валидность клетки и соседство
            guard destination.row >= 0 && destination.row <= state.map.maxRow,
                  destination.column >= state.map.minColumn && destination.column <= state.map.maxColumn,
                  unitPos.isAdjacent(with: destination) else { return state }
        }
        
        // 4. Выполняем перемещение и установку Exposed
        var newUnitPosition = state.unitState.unitPosition
        newUnitPosition[recipient] = destination
        var newExposed = state.unitState.unitExposed
        newExposed.insert(recipient)
        let newUnitState = state.unitState.copy(unitPosition: newUnitPosition, unitExposed: newExposed)
        
        // 5. Списываем команды
        var newCommandState = state.unitState.commandState
        newCommandState[originator] = hqCmd.copy(activated: hqCmd.activated - cmdCost)
        let finalUnitState = newUnitState.copy(commandState: newCommandState)
        
        return state.copy(unitState: finalUnitState)
    }
}
