// Core/CommandResult.swift

enum CommandResult {
    case success(GameState)
    case failure(CommandError, GameState)  // ошибка + исходный state
}

enum CommandError: Equatable {
    case unitNotFound
    case unitExposed
    case noVisualVerbalContact
    case outOfBounds
    case notAdjacent
    case notEnoughCommands
    case originatorNotFound
    // потом добавятся: unitPinned, wrongPhase, unitNotOnMap, etc.

    var description: String {
        switch self {
        case .unitNotFound: return "Юнит не найден"
        case .unitExposed: return "Юнит уже Exposed"
        case .noVisualVerbalContact: return "Нет визуально-вербального контакта со штабом"
        case .outOfBounds: return "Координаты за пределами карты"
        case .notAdjacent: return "Клетка не соседняя"
        case .notEnoughCommands: return "Недостаточно команд"
        case .originatorNotFound: return "Штаб не найден или не имеет команд"
        }
    }
}
