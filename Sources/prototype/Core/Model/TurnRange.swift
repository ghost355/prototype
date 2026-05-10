struct TurnRange: Codable, Equatable {
    // ожидает ввода "2-5" ход со второго по пятый
    let fromTurn: Int
    let toTurn: Int

    init?(string: String) {
        let parts = string.split(separator: "-")
        guard parts.count == 2,
            let first = Int(parts[0]),
            let second = Int(parts[1]),
            first <= second
        else { return nil }
        fromTurn = first
        toTurn = second
    }

    func matches(_ turn: Int) -> Bool {
        return turn >= fromTurn && turn <= toTurn
    }
}
