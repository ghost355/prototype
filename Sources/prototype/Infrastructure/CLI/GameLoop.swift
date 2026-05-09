// Infrastructure/CLI/GameLoop.swift

import Foundation

enum GameLoop {
    // MARK: - Состояния контекста меню

    enum MenuContext {
        case main
    }

    // MARK: - Параметры интерфейса

    private enum UI {
        static let startCol = 1
        static let panelWidth = 100
        static let infoPanelHeight = 10
        static let menuPanelHeight = 15
        static let inputPanelHeight = 3
        static let helpPanelHeight = 6
        static let infoPanelRow = 1
        static let menuPanelRow = infoPanelRow + infoPanelHeight
        static let inputPanelRow = menuPanelRow + menuPanelHeight
        static let helpPanelRow = inputPanelRow + inputPanelHeight
    }

    // MARK: - Публичный вход

    static func run(initialState: GameState, drawing: ActionCardDrawing) {
        var state = initialState
        var currentContext: MenuContext = .main
        var errorMessage: String?

        // Инициализация интерфейса
        initializeUI(state: state)

        // Игровой цикл
        while state.info.isGameRunning {

            showInfo(textLines: infoText(for: currentContext, state: state))

            showContextMenu(for: currentContext, state: state, errorMessage: &errorMessage)

            clearInputPanel()
            guard let input = readLine() else { continue }
            handleInput(
                input, for: &currentContext, state: &state, errorMessage: &errorMessage,
                drawing: drawing)
        }

        // Завершение
        Renderer.showCursor()
        Renderer.clearScreen()
        print("До свидания!")
    }

    // MARK: - Инициализация интерфейса

    private static func initializeUI(state: GameState) {
        Renderer.clearScreen()
        Renderer.hideCursor()

        // Панель вывода информации
        Renderer.drawBox(
            startRow: UI.infoPanelRow, startCol: UI.startCol,
            width: UI.panelWidth, height: UI.infoPanelHeight
        )

        // Панель меню
        Renderer.drawBox(
            startRow: UI.menuPanelRow, startCol: UI.startCol, width: UI.panelWidth,
            height: UI.menuPanelHeight
        )

        // Панель ввода
        Renderer.drawBox(
            startRow: UI.inputPanelRow, startCol: UI.startCol, width: UI.panelWidth,
            height: UI.inputPanelHeight
        )
        Renderer.drawText(
            "> ", atRow: UI.inputPanelRow + 1, col: UI.startCol + 2, maxWidth: UI.panelWidth - 4
        )

        // Панель подсказок
        Renderer.drawBox(
            startRow: UI.helpPanelRow, startCol: UI.startCol, width: UI.panelWidth,
            height: UI.helpPanelHeight
        )
    }

    // MARK: - Меню

    private static func showInfo(textLines: [String]) {
        Renderer.clearPanel(
            startRow: UI.infoPanelRow, startCol: UI.startCol, width: UI.panelWidth,
            height: UI.infoPanelHeight)
        for (num, line) in textLines.enumerated() {

            Renderer.drawText(
                line, atRow: UI.infoPanelRow + 1 + num, col: UI.startCol + 2,
                maxWidth: UI.panelWidth - 4,
                color: .cyan)

        }
    }

    private static func showContextMenu(
        for context: MenuContext, state: GameState, errorMessage: inout String?
    ) {
        let items = menuItems(for: context, state: state)
        let helpText = errorMessage ?? helpMessage(for: context)

        Renderer.clearPanel(
            startRow: UI.menuPanelRow, startCol: UI.startCol, width: UI.panelWidth,
            height: UI.menuPanelHeight
        )
        for (index, item) in items.enumerated() {
            Renderer.drawText(
                "\(index + 1). \(item)", atRow: UI.menuPanelRow + 1 + index,
                col: UI.startCol + 2, maxWidth: UI.panelWidth - 4, color: .red
            )
        }

        Renderer.clearPanel(
            startRow: UI.helpPanelRow, startCol: UI.startCol, width: UI.panelWidth,
            height: UI.helpPanelHeight
        )
        Renderer.drawText(
            helpText, atRow: UI.helpPanelRow + 1,
            col: UI.startCol + 2,
            maxWidth: UI.panelWidth - 4
        )

        errorMessage = nil
    }

    private static func menuItems(for context: MenuContext, state _: GameState) -> [String] {
        switch context {
        case .main:
            return ["Завершить фазу", "Выйти из игры"]
        }
    }

    private static func helpMessage(for context: MenuContext) -> String {
        switch context {
        case .main:
            return "Главное меню. Выберите действие. Введите число и нажмите Enter."
        }
    }

    private static func infoText(for context: MenuContext, state: GameState) -> [String] {
        switch context {
        case .main:
            return [
                Renderer.coloredText(
                    "TURN: \(state.info.turn) \t \(state.info.phase.name)", color: .green)
            ]
        }
    }

    // MARK: - Ввод

    private static func clearInputPanel() {
        Renderer.clearPanel(
            startRow: UI.inputPanelRow + 1, startCol: UI.startCol + 2,
            width: UI.panelWidth - 4, height: 1
        )
        Renderer.drawText(
            "> ", atRow: UI.inputPanelRow + 1, col: UI.startCol + 2, maxWidth: UI.panelWidth - 4
        )
    }

    private static func handleInput(
        _ choice: String,
        for context: inout MenuContext,
        state: inout GameState,
        errorMessage: inout String?,
        drawing: ActionCardDrawing
    ) {
        let items = menuItems(for: context, state: state)
        guard let choiceInt = Int(choice), choiceInt >= 1, choiceInt <= items.count else {
            errorMessage = Renderer.coloredText(
                "Неверный выбор. Введите число от 1 до \(items.count).", color: .red)
            return
        }

        switch context {
        case .main:
            switch choiceInt {
            case 1:
                // Переход к следующей фазе
                state = GameEngine.apply(state: state, action: .phase(.finish), drawing: drawing)
            case 2:
                // Выход
                state = GameEngine.apply(state: state, action: .game(.exit), drawing: drawing)
            default:
                break
            }
        }
    }
}
