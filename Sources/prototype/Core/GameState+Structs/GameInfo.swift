// GameInfo.swift

struct GameInfo: Codable {
    let turn: Int
    let maxTurns: Int
    let phase: GamePhase

    var isOver: Bool {
        turn > maxTurns
    }
}
