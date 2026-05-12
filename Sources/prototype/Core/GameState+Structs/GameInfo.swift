/// Core/GameState+Structs/GameInfo.swift
struct GameInfo: Codable, Equatable {
    let missionType: MissionType
    let turn: Int
    let maxTurns: Int
    let isGameRunning: Bool

    var isOver: Bool {
        turn > maxTurns
    }

    func copy(
        missionType: MissionType? = nil,
        turn: Int? = nil,
        maxTurns: Int? = nil,
        isGameRunning: Bool? = nil
    ) -> Self {
        Self(
            missionType: missionType ?? self.missionType,
            turn: turn ?? self.turn,
            maxTurns: maxTurns ?? self.maxTurns,
            isGameRunning: isGameRunning ?? self.isGameRunning
        )
    }
}
