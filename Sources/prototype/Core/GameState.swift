// GameState.swift

struct GameState: Codable {
    let map: Map
    let info: GameInfo
    let units: [UnitID: Unit]
    let unitState: UnitState

}
