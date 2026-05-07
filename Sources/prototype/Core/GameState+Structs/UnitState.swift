// UnitState.swift

struct UnitState: Codable {
    let unitPosition: [UnitID: GridCoordinate]
    let unitExposed: Set<UnitID>
    let unitPinned: Set<UnitID>
}
