// GameInfo.swift

struct GameInfo: Codable {
    let turn: Int
    let maxTurns: Int
    let phase: GamePhase

    let availableCommand: Int

    var isOver: Bool { turn > maxTurns }
}
