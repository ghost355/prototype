// Core/Model/HitEffectEntry.swift

struct HitEffectEntry: Codable, Equatable {
    let experience: ExperienceLevel
    let effects: [HitEffect]
}
