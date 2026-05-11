// TableGeneric.swift

struct GenericTable<Value: Codable & Equatable>: Codable, Equatable {
    let upperBound: Int
    let entries: [GenericTableEntry<Value>]

    func resolve(number: Int, turn: Int) -> Value? {
        entries.first { entry in
            entry.turnRange.matches(turn) && entry.randomRange.matches(number)
        }?.value
    }
}

struct GenericTableEntry<Value: Codable & Equatable>: Codable, Equatable {
    let type: String
    let description: String
    let turnRange: TurnRange
    let randomRange: RandomRange
    let value: Value
}
