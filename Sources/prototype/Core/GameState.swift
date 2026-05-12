/// Core/GameState.swift
struct GameState: Codable, Equatable {
    let map: Map
    let info: GameInfo
    let units: [UnitID: Unit]
    let unitState: UnitState
    let debugMessage: String

    var phaseDescriptors: [PhaseDescriptor] {
        info.missionType.phaseDescriptors
    }

    func copy(
        map: Map? = nil,
        info: GameInfo? = nil,
        units: [UnitID: Unit]? = nil,
        unitState: UnitState? = nil,
        debugMessage: String? = nil
    ) -> Self {
        Self(
            map: map ?? self.map,
            info: info ?? self.info,
            units: units ?? self.units,
            unitState: unitState ?? self.unitState,
            debugMessage: debugMessage ?? self.debugMessage
        )
    }
}
