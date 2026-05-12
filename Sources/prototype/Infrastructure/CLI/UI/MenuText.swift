// Infrastructure/CLI/UI/MenuText.swift
import Foundation

enum MenuContext {
    case main
}

enum MenuText {
    static func items(for context: MenuContext, state _: GameState) -> [String] {
        switch context {
        case .main: return ["Завершить фазу", "Войти в Демо-меню"]
        }
    }

    static func help(for context: MenuContext) -> String {
        switch context {
        case .main:
            return "Главное меню. Выберите действие. Введите число и нажмите Enter."
        }
    }

    static func info(for context: MenuContext, state: GameState) -> [String] {
        switch context {
        case .main:
            return [
                    "ХОД: \(state.info.turn) \t \(state.info.phase.name)".color(.green),
                    "\(state.debugMessage)".color(.magenta)
            ]
        }
    }
}
