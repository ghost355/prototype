// Core/GameState+Structs/GameInfo.swift

struct GameInfo: Codable, Equatable {
    let missionType: MissionType
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
        missionType: MissionType? = nil,
        turn: Int? = nil,
        maxTurns: Int? = nil,
        phase: GamePhase? = nil,
        isGameRunning: Bool? = nil
    ) -> Self {
        Self(
            missionType: missionType ?? self.missionType,
            turn: turn ?? self.turn,
            maxTurns: maxTurns ?? self.maxTurns,
            phase: phase ?? self.phase,
            isGameRunning: isGameRunning ?? self.isGameRunning
        )
    }
}
