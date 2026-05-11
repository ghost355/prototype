// Core/Model/HQEventEntry.swift

struct HQEventEntry: Codable, Equatable {
    let name: String
    let slots: [HQEventSlot]
}

struct HQEventSlot: Codable, Equatable {
    let fromTurn: Int
    let toTurn: Int
    let rangeString: String  // "1/2", "4/9"

    var range: RangeValue? {
        return RangeValue(string: rangeString)
    }

    func matches(turn: Int) -> Bool {
        return turn >= fromTurn && turn <= toTurn
    }
}
