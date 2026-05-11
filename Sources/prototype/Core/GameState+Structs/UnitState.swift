// Core/GameState+Structs/UnitState.swift

struct UnitState: Codable, Equatable {
    let unitPosition: [UnitID: GridCoordinate]
    let unitExposed: Set<UnitID>
    let unitPinned: Set<UnitID>
    let commandState: [UnitID: CommandState]
}

extension UnitState {
    func copy(
        unitPosition: [UnitID: GridCoordinate]? = nil,
        unitExposed: Set<UnitID>? = nil,
        unitPinned: Set<UnitID>? = nil,
        commandState: [UnitID: CommandState]? = nil
    ) -> Self {
        Self(
            unitPosition: unitPosition ?? self.unitPosition,
            unitExposed: unitExposed ?? self.unitExposed,
            unitPinned: unitPinned ?? self.unitPinned,
            commandState: commandState ?? self.commandState
        )
    }
}
