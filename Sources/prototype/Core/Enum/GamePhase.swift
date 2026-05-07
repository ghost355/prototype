// GameUnit.swift

enum GamePhase: String, Codable {
    case friendlyHQEvent
    case defensiveEnemyActivity
    case friendlyCommand
    case offensivePatrolEnemyActivity
    case mutualCaptureRetreat
    case atCombatVehicleMovement
    case mutualCombat
    case cleanUp
}
