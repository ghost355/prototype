// Infrastructure/CLI/UI/MenuText.swift
import Foundation

enum MenuText {
    static func items(for context: GameLoop.MenuContext, state _: GameState) -> [String] {
        switch context {
        case .main: return ["Завершить фазу", "Войти в Демо-меню"]
        }
    }

    static func help(for context: GameLoop.MenuContext) -> String {
        switch context {
        case .main:
            return "Главное меню. Выберите действие. Введите число и нажмите Enter."
        }
    }

    static func info(for context: GameLoop.MenuContext, state: GameState) -> [String] {
        switch context {
        case .main:
            return [
                Renderer.coloredText(
                    "ХОД: \(state.info.turn) \t \(state.info.phase.name)", color: .green
                ),
                Renderer.coloredText(
                    "\(state.debugMessage)", color: .magenta
                ),
            ]
        }
    }
}
