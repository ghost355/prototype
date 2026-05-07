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

    var name: String {
        switch self {
        case .friendlyHQEvent: return "Фаза событий дружественного вышестоящего HQ"
        case .friendlyCommand: return "Фаза дружественного командования"
        case .defensiveEnemyActivity: return "Фаза активности противника (оборона)"
        case .offensivePatrolEnemyActivity: return "Фаза активности противника (нападение/патруль)"
        case .mutualCaptureRetreat: return "Фаза обоюдного захвата и отступления"
        case .atCombatVehicleMovement: return "Фаза ПТ-боя и движения техники"
        case .mutualCombat: return "Фаза обоюдного боя"
        case .cleanUp: return "Фаза очистки"
        }
    }
}
