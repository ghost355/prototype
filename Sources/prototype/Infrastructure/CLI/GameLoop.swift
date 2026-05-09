// Infrastructure/CLI/GameLoop.swift
import Foundation

enum GameLoop {
    enum MenuContext {
        case main
        case demo
    }

    static func run(initialState: GameState, drawing: ActionCardDrawing) {
        var state = initialState
        var currentContext: MenuContext = .main
        var errorMessage: String?
        ViewController.initializeUI(state: state)

        while state.info.isGameRunning {
            ViewController.showInfo(textLines: MenuText.info(for: currentContext, state: state))
            // Вызываем свой showContextMenu
            showContextMenu(for: currentContext, state: state, errorMessage: &errorMessage)
            ViewController.clearInputPanel()

            guard let input = readLine() else { continue }

            handleInput(
                input,
                for: &currentContext,
                state: &state,
                errorMessage: &errorMessage,
                drawing: drawing
            )
        }

        Renderer.showCursor()
        Renderer.clearScreen()
        print("До свидания!")
    }

    // MARK: - Отрисовка контекстного меню

    private static func showContextMenu(
        for context: MenuContext, state: GameState, errorMessage: inout String?
    ) {
        let items = MenuText.items(for: context, state: state)
        let helpText = errorMessage ?? MenuText.help(for: context)

        // Очистка панели меню
        Renderer.clearPanel(
            startRow: LayoutConstants.menuRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.menuHeight
        )

        // Универсальный пункт "0"
        let backLabel = context == .main ? "Выход из игры" : "Назад в главное меню"
        Renderer.drawText(
            "0. \(backLabel)",
            atRow: LayoutConstants.menuRow + 1,
            col: LayoutConstants.startCol + 2,
            maxWidth: LayoutConstants.panelWidth - 4,
            color: .yellow)

        // Основные пункты
        for (index, item) in items.enumerated() {
            Renderer.drawText(
                "\(index + 1). \(item)",
                atRow: LayoutConstants.menuRow + 2 + index,
                col: LayoutConstants.startCol + 2,
                maxWidth: LayoutConstants.panelWidth - 4,
                color: .red)
        }

        // Очистка и вывод подсказки
        Renderer.clearPanel(
            startRow: LayoutConstants.helpRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.helpHeight
        )
        Renderer.drawText(
            helpText, atRow: LayoutConstants.helpRow + 1,
            col: LayoutConstants.startCol + 2,
            maxWidth: LayoutConstants.panelWidth - 4)
        errorMessage = nil
    }

    // MARK: - Обработка ввода

    private static func handleInput(
        _ choice: String,
        for context: inout MenuContext,
        state: inout GameState,
        errorMessage: inout String?,
        drawing: ActionCardDrawing
    ) {
        // Универсальная обработка "0"
        if choice == "0" {
            if context == .main {
                state = GameEngine.apply(state: state, action: .game(.exit), drawing: drawing)
            } else {
                context = .main
            }
            return
        }

        let items = MenuText.items(for: context, state: state)
        guard let choiceInt = Int(choice), choiceInt >= 1, choiceInt <= items.count else {
            errorMessage = Renderer.coloredText(
                "Неверный выбор. Введите число от 0 до \(items.count).", color: .red)
            return
        }

        // Делегирование обработчикам
        switch context {
        case .main:
            MainMenuHandler.handle(
                choice: choiceInt, context: &context, state: &state, drawing: drawing)
        case .demo:
            DemoMenuHandler.handle(
                choice: choiceInt, context: &context, state: &state, drawing: drawing)
        }
    }
}
