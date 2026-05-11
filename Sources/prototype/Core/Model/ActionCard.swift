// Core/Model/ActionCard.swift
import Foundation

struct ActionCard: Codable, Equatable {
    let id: Int
    let activatedCommands: Int
    let initiativeCommands: Int
    let atNumber: Int
    let icons: Set<ActionIcon>
    let combatResults: [Int: CombatResult]
    let hitEffects: [HitEffectEntry]
    let randomNumbers: [Int]
}

/// Удобный хелпер для получения случайного числа
extension ActionCard {
    func randomNumber(for upperBound: Int) -> Int? {
        // Столбцы 2...12, индексы 0...10
        let index = upperBound - 2
        guard index >= 0, index < randomNumbers.count else { return nil }
        return randomNumbers[index]
    }

    func hasIcon(_ icon: ActionIcon) -> Bool {
        icons.contains(icon)
    }
}
