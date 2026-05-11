// Core/GameState+Structs/Map.swift

struct Map: Codable {
    let cells: [GridCoordinate: Cell]
    let rows: Int
    let columns: Int

    let minColumn: Int
    let maxColumn: Int
    let maxRow: Int

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.minColumn = 0
        self.maxColumn = columns - 1
        self.maxRow = rows
        self.cells = [:]
    }
}
