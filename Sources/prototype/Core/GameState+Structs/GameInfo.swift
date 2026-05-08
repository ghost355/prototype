// GameInfo.swift

struct GameInfo: Codable {
    let turn: Int
    let maxTurns: Int
    let phase: GamePhase

    let isGameRunning: Bool

    var isOver: Bool {
        turn > maxTurns
    }
}

extension GameInfo {
    func copy(
        turn: Int? = nil,
        maxTurns: Int? = nil,
        phase: GamePhase? = nil,
        isGameRunning: Bool? = nil
    ) -> Self {
        Self(
            turn: turn ?? self.turn,
            maxTurns: maxTurns ?? self.maxTurns,
            phase: phase ?? self.phase,
            isGameRunning: isGameRunning ?? self.isGameRunning
        )
    }
}
