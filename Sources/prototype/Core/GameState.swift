// GameState.swift

struct GameState: Codable {
    let map: Map
    let info: GameInfo
    let units: [UnitID: Unit]
    let unitState: UnitState
}

extension GameState {
    func copy(
        map: Map? = nil,
        info: GameInfo? = nil,
        units: [UnitID: Unit]? = nil,
        unitState: UnitState? = nil
    ) -> Self {
        Self(
            map: map ?? self.map,
            info: info ?? self.info,
            units: units ?? self.units,
            unitState: unitState ?? self.unitState
        )
    }
}
