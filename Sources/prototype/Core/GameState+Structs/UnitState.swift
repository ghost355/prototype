// Core/GameState+Structs/UnitState.swift

struct UnitState: Codable {
    let unitPosition: [UnitID: GridCoordinate]
    let unitExposed: Set<UnitID>
    let unitPinned: Set<UnitID>
}

extension UnitState {
    func copy(
        unitPosition: [UnitID: GridCoordinate]? = nil,
        unitExposed: Set<UnitID>? = nil,
        unitPinned: Set<UnitID>? = nil
    ) -> Self {
        Self(
            unitPosition: unitPosition ?? self.unitPosition,
            unitExposed: unitExposed ?? self.unitExposed,
            unitPinned: unitPinned ?? self.unitPinned
        )
    }
}
