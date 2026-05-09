// Core/GameState+Structs/Map.swift

struct Map: Codable {
    let cells: [GridCoordinate: Cell]
}
