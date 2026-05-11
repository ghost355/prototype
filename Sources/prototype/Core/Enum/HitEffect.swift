// Core/Enum/HitEffect.swift

enum HitEffect: String, Codable {
    case fireteam
    case assault
    case litter
    case paralyzed
    case casualty

    var letter: String {
        switch self {
        case .fireteam: return "F"
        case .assault: return "A"
        case .litter: return "L"
        case .paralyzed: return "P"
        case .casualty: return "C"
        }
    }
}
