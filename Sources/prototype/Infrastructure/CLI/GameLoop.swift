// GameLoop.swift

import Foundation

enum GameLoop {
    static func run(initialState: GameState, drawing _: ActionCardDrawing) {
        var state = initialState

        let startCol = 1
        let panelWidth = 100
        let infoPanelHeight = 10
        let menuPanelHeight = 15
        let inputPanelHeight = 3
        let helpPanelHeight = 6
        let infoPanelRow = 1
        let menuPanelRow = infoPanelRow + infoPanelHeight
        let inputPanelRow = menuPanelRow + menuPanelHeight
        let helpPanelRow = inputPanelRow + inputPanelHeight

        let clearHelpPanel = {
            Renderer.clearPanel(
                startRow: helpPanelRow, startCol: startCol, width: panelWidth,
                height: helpPanelHeight)
        }

        let showHelpMessage = {
            Renderer.drawMessage(
                $0, atRow: helpPanelRow + 1, col: startCol + 2, maxWidth: panelWidth - 4)
        }

        let clearInputPanel = {
            Renderer.clearPanel(
                startRow: inputPanelRow + 1, startCol: startCol + 2, width: panelWidth - 4,
                height: 1)
            Renderer.drawText(
                "> ", atRow: inputPanelRow + 1, col: startCol + 2, maxWidth: panelWidth - 4)
        }

        let showMenu = {
            let menuItems: [String] = $0
            Renderer.clearPanel(
                startRow: menuPanelRow, startCol: startCol, width: panelWidth,
                height: menuPanelHeight)
            for (number, item) in menuItems.enumerated() {
                let menuLine = "\(number + 1). \(item)"
                Renderer.drawMessage(
                    menuLine, atRow: menuPanelRow + 1 + number, col: startCol + 2,
                    maxWidth: panelWidth - 4)
            }

        }

        Renderer.clearScreen()
        Renderer.hideCursor()
        // Панель с информацией
        Renderer.drawInfoPanel(
            state: state, startRow: infoPanelRow, startCol: startCol, width: panelWidth,
            height: infoPanelHeight
        )
        // Панель меню
        Renderer.drawBox(
            startRow: menuPanelRow, startCol: startCol, width: panelWidth,
            height: menuPanelHeight
        )
        // Панель для ввода
        Renderer.drawBox(
            startRow: inputPanelRow, startCol: startCol, width: panelWidth,

            height: inputPanelHeight
        )
        Renderer.drawText(
            "> ", atRow: inputPanelRow + 1, col: startCol + 2, maxWidth: panelWidth - 4
        )

        // Панель подсказок
        Renderer.drawBox(
            startRow: helpPanelRow, startCol: startCol, width: panelWidth, height: helpPanelHeight
        )
        Renderer.drawMessage(
            "Подсказки для ввода: Нажмите Enter и приложение завершится. А что если будет ооочоень длиная стока прям оооочень длинаая что будет? ААААААы",
            atRow: helpPanelRow + 1,
            col: startCol + 2, maxWidth: panelWidth - 4, color: .cyan
        )

        // MARK: Игровой цикл
        while !state.info.isOver {

            let menuItems = ["Первый пункт", "Второй пункт", "Завершить"]

            showMenu(menuItems)

            clearInputPanel()

            guard let input = readLine() else { break }
            if input.lowercased() == "exit" || input.lowercased() == "quit" { break }

            clearHelpPanel()
            showHelpMessage(input)

        }

        _ = readLine()

        Renderer.showCursor()
        Renderer.clearScreen()
        print("До свидания!")
    }
}
