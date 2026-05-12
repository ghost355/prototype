// Infrastructure/CLI/GameLoop.swift
import Foundation

enum GameLoop {
    // MARK: - Контексты приложения

    enum AppContext {
        case mainMenu
        case game
    }

    // MARK: - Публичный вход

    static func run(initialState: GameState, drawing: ActionCardDrawing) {
        var state = initialState

        var appContext: AppContext = .mainMenu
        var currentContext: MenuContext = .main

        var errorMessage: String?
        var phaseNotExecuted = true

        ViewController.initializeUI(state: state)

        // Главный цикл приложения
        while state.info.isGameRunning {
            switch appContext {
            case .mainMenu:
                // --- RENDER ---
                ViewController.showInfo(
                    textLines: MenuText.info(for: appContext, menuContext: currentContext, state: state)
                )
                // TODO: refacor: move to ViewController
                showContextMenu(
                    for: appContext, menuContext: currentContext, state: state,
                    errorMessage: &errorMessage
                )
                ViewController.clearInputPanel()

                // --- INPUT ---
                guard let input = readLine() else { continue }
                handleInput(
                    input,
                    menuContext: &currentContext,
                    appContext: &appContext,
                    state: &state,
                    errorMessage: &errorMessage,
                    drawing: drawing
                )

            case .game:
                var phaseIndex = 0
                var phaseNotExecuted = true

                // Выполняем фазу при первом входе
                if phaseNotExecuted {
                    state = PhaseProcessor.executePhase(state: state, drawing: drawing, phaseIndex: phaseIndex)
                    phaseNotExecuted = false
                }

                // --- RENDER ---
                let descriptor = state.phaseDescriptors[phaseIndex]
                ViewController.showInfo(
                    textLines: MenuText.info(for: appContext, menuContext: currentContext, state: state, phaseName: descriptor.name)
                )
                showContextMenu(
                    for: appContext, menuContext: currentContext, state: state,
                    errorMessage: &errorMessage
                )
                ViewController.clearInputPanel()

                // --- INPUT ---
                guard let input = readLine() else { continue }
                handleInput(
                    input,
                    menuContext: &currentContext,
                    appContext: &appContext,
                    state: &state,
                    errorMessage: &errorMessage,
                    drawing: drawing,
                    onFinishPhase: {
                        state = PhaseProcessor.nextPhase(state: state, currentIndex: phaseIndex)
                        phaseIndex = (phaseIndex + 1) % state.phaseDescriptors.count
                        phaseNotExecuted = true
                    }
                )
            }
        }

        // Завершение приложения
        Renderer.showCursor()
        Renderer.clearScreen()
        print("До свидания!")
    }

    // MARK: - Отрисовка контекстного меню

    private static func showContextMenu(
        for appContext: AppContext,
        menuContext: MenuContext,
        state: GameState,
        errorMessage: inout String?
    ) {
        let items = MenuText.items(for: appContext, menuContext: menuContext, state: state)
        let helpText = errorMessage ?? MenuText.help(for: appContext, menuContext: menuContext)

        Renderer.clearPanel(
            startRow: LayoutConstants.menuRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.menuHeight
        )

        let backLabel = menuContext == .main && appContext == .mainMenu ? "Выход из игры" : "Назад в главное меню"
        Renderer.drawText(
            "0. \(backLabel)",
            atRow: LayoutConstants.menuRow + 1,
            col: LayoutConstants.startCol + 2,
            maxWidth: LayoutConstants.panelWidth - 4,
            color: .yellow
        )

        for (index, item) in items.enumerated() {
            Renderer.drawText(
                "\(index + 1). \(item)",
                atRow: LayoutConstants.menuRow + 2 + index,
                col: LayoutConstants.startCol + 2,
                maxWidth: LayoutConstants.panelWidth - 4,
                color: .red
            )
        }

        Renderer.clearPanel(
            startRow: LayoutConstants.helpRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.helpHeight
        )
        Renderer.drawText(
            helpText, atRow: LayoutConstants.helpRow + 1,
            col: LayoutConstants.startCol + 2,
            maxWidth: LayoutConstants.panelWidth - 4
        )
        errorMessage = nil
    }

    // MARK: - Обработка ввода

    private static func handleInput(
        _ choice: String,
        menuContext: inout MenuContext,
        appContext: inout AppContext,
        state: inout GameState,
        errorMessage: inout String?,
        drawing: ActionCardDrawing,
        onFinishPhase _: (() -> Void)? = nil
    ) {
        if choice == "0" {
            switch (appContext, menuContext) {
            case (.mainMenu, .main):
                state = GameEngine.apply(state: state, action: .game(.exit), drawing: drawing)
            case (_, .main):
                appContext = .mainMenu
            default:
                menuContext = .main
            }
            return
        }

        let items = MenuText.items(for: appContext, menuContext: menuContext, state: state)
        guard let choiceInt = Int(choice), choiceInt >= 1, choiceInt <= items.count else {
            errorMessage = Renderer.coloredText(
                "Неверный выбор. Введите число от 0 до \(items.count).", color: .red
            )
            return
        }

        switch (appContext, menuContext) {
        case (.mainMenu, .main):
            MainMenuHandler.handle(
                choice: choiceInt,
                menuContext: &menuContext,
                appContext: &appContext,
                state: &state,
                drawing: drawing
            )
        default:
            break
        }
    }
}
