// Core/Model/GridCoordinate.swift

struct GridCoordinate: Codable, Equatable, Hashable {
    let row: Int
    let column: Int
}

extension GridCoordinate {

    static func + (lhs: GridCoordinate, rhs: GridCoordinate) -> GridCoordinate {
        GridCoordinate(row: lhs.row + rhs.row, column: lhs.column + rhs.column)
    }

    static func - (lhs: GridCoordinate, rhs: GridCoordinate) -> GridCoordinate {
        GridCoordinate(row: lhs.row - rhs.row, column: lhs.column - rhs.column)
    }

    static prefix func - (coord: GridCoordinate) -> GridCoordinate {
        GridCoordinate(row: -coord.row, column: -coord.column)
    }

    static func * (lhs: GridCoordinate, rhs: Int) -> GridCoordinate {
        GridCoordinate(row: lhs.row * rhs, column: lhs.column * rhs)
    }

    static func * (lhs: Int, rhs: GridCoordinate) -> GridCoordinate {
        GridCoordinate(row: lhs * rhs.row, column: lhs * rhs.column)
    }

    var normalized: GridCoordinate {
        GridCoordinate(
            row: row == 0 ? 0 : (row > 0 ? 1 : -1),
            column: column == 0 ? 0 : (column > 0 ? 1 : -1)
        )
    }

    func isAdjacent(with target: GridCoordinate) -> Bool {
        let delta = target - self
        return self != target && max(delta.row, delta.column) == 1 ? true : false

    }
}
