// Core/GameState+Structs/Map.swift

struct Map: Codable, Equatable {
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
        var dict: [GridCoordinate: Cell] = [:]
        for row in 0...rows {
            for col in 1...columns {
                dict[GridCoordinate(row: row, column: col)] = Cell(terrain: [])
            }
        }
        self.cells = dict
    }
}
