/// Core/Enum/MissionType.swift
enum MissionType: String, Codable {
    case offensive
    case defensive
    case patrol

    var phaseDescriptors: [PhaseDescriptor] {
        switch self {
        case .offensive:
            return [
                PhaseDescriptor(name: "Friendly HQ Event", isInteractive: false, execute: FriendlyHQEvent.execute),
                PhaseDescriptor(name: "Friendly Command", isInteractive: true, execute: FriendlyCommand.execute),
                PhaseDescriptor(name: "Offensive/Patrol Enemy Activity", isInteractive: false, execute: OffensivePatrolEnemyActivity.execute),
                PhaseDescriptor(name: "Mutual Capture/Retreat", isInteractive: false, execute: MutualCaptureRetreat.execute),
                PhaseDescriptor(name: "AT Combat/Vehicle Movement", isInteractive: true, execute: AtCombatVehicleMovement.execute),
                PhaseDescriptor(name: "Mutual Combat", isInteractive: false, execute: MutualCombat.execute),
                PhaseDescriptor(name: "Clean Up", isInteractive: false, execute: CleanUp.execute),
            ]
        case .defensive:
            return [
                PhaseDescriptor(name: "Defensive Enemy Activity", isInteractive: false, execute: DefensiveEnemyActivity.execute),
                PhaseDescriptor(name: "Friendly HQ Event", isInteractive: false, execute: FriendlyHQEvent.execute),
                PhaseDescriptor(name: "Friendly Command", isInteractive: true, execute: FriendlyCommand.execute),
                PhaseDescriptor(name: "Mutual Capture/Retreat", isInteractive: false, execute: MutualCaptureRetreat.execute),
                PhaseDescriptor(name: "AT Combat/Vehicle Movement", isInteractive: true, execute: AtCombatVehicleMovement.execute),
                PhaseDescriptor(name: "Mutual Combat", isInteractive: false, execute: MutualCombat.execute),
                PhaseDescriptor(name: "Clean Up", isInteractive: false, execute: CleanUp.execute),
            ]
        case .patrol:
            return Self.offensive.phaseDescriptors
        }
    }
}
