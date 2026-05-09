// Core/Enum/MissionType.swift

enum MissionType: String, Codable {
    case offensive
    case defensive
    case patrol

    var phaseSequence: [GamePhase] {
        switch self {
        case .offensive:
            return [
                .friendlyHQEvent,
                .friendlyCommand,
                .offensivePatrolEnemyActivity,
                .mutualCaptureRetreat,
                .atCombatVehicleMovement,
                .mutualCombat,
                .cleanUp,
            ]
        case .defensive:
            return [
                .defensiveEnemyActivity,
                .friendlyHQEvent,
                .friendlyCommand,
                .mutualCaptureRetreat,
                .atCombatVehicleMovement,
                .mutualCombat,
                .cleanUp,
            ]
        case .patrol:
            return [
                .friendlyHQEvent,
                .friendlyCommand,
                .offensivePatrolEnemyActivity,
                .mutualCaptureRetreat,
                .atCombatVehicleMovement,
                .mutualCombat,
                .cleanUp,
            ]
        }
    }
}
