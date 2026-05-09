// Infrastructure/CLI/UI/LayoutConstants.swift
import Foundation

enum LayoutConstants {
    // Сетка
    static let startCol = 1
    static let panelWidth = 100
    
    // Высоты панелей (можно регулировать)
    static let infoHeight = 10
    static let menuHeight = 15
    static let inputHeight = 3
    static let helpHeight = 6
    
    // Вычисляемые позиции (чтобы не считать вручную)
    static let infoRow = 1
    static let menuRow = infoRow + infoHeight
    static let inputRow = menuRow + menuHeight
    static let helpRow = inputRow + inputHeight
    
    // Цвета (дублируем сюда для удобства, или оставить ссылки на TextColor)
    // Пока оставим так, потом можно вынести в ColorPalette
}

// Если хотите управлять текстом из одного места
enum MenuText {
    static func items(for context: GameLoop.MenuContext, state: GameState) -> [String] {
        switch context {
        case .main: return ["Завершить фазу", "Войти в Демо-меню", "Выйти из игры"]
        case .demo: return ["Раздел 1", "Раздел 2", "Вернутся обратно"]
        }
    }
    
    static func help(for context: GameLoop.MenuContext) -> String {
        switch context {
        case .main: return "Главное меню. Выберите действие. Введите число и нажмите Enter."
        case .demo: return "Демо-меню второго уровня вложенности. Введите число и нажмите Enter. Есть возврат обратно."
        }
    }
    
    static func info(for state: GameState) -> [String] {
        return [
            Renderer.coloredText(
                "TURN: \(state.info.turn) \t \(state.info.phase.name)", color: .green
            ),
        ]
    }
}
