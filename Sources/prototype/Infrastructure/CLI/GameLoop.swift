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
            ViewController.showInfo(textLines: MenuText.info(for: state))
            ViewController.showContextMenu(for: currentContext, state: state, errorMessage: &errorMessage)
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

    // MARK: - Обработка ввода

    private static func handleInput(
        _ choice: String,
        for context: inout MenuContext,
        state: inout GameState,
        errorMessage: inout String?,
        drawing: ActionCardDrawing
    ) {
        let items = MenuText.items(for: context, state: state)
        guard let choiceInt = Int(choice), choiceInt >= 1, choiceInt <= items.count else {
            errorMessage = Renderer.coloredText(
                "Неверный выбор. Введите число от 1 до \(items.count).", color: .red
            )
            return
        }

        switch context {
        case .main:
            MainMenuHandler.handle(choice: choiceInt, context: &context, state: &state, drawing: drawing)
        case .demo:
            DemoMenuHandler.handle(choice: choiceInt, context: &context, state: &state, drawing: drawing)
        }
    }
}
