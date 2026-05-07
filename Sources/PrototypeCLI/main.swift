import Foundation

@testable import prototype

// MARK: - Заглушки для первого запуска

struct StubDrawing: ActionCardDrawing {
    func drawCards(count: Int) -> [ActionCard] {
        // Пока возвращаем пустой массив — никаких карт не нужно
        []
    }
}

// MARK: - Точка входа
@main
struct GameCLI {
    static func main() {
        // 1. Создаём начальное состояние (пока вручную)
        var state = GameState(
            map: Map(cells: [:]),
            info: GameInfo(turn: 1, maxTurns: 10, phase: .friendlyCommand, availableCommand: 3),
            units: [
                "hq": Unit(id: "hq"),
                "sq1": Unit(id: "sq1"),
                "sq2": Unit(id: "sq2")
            ],
            unitState: UnitState(
                unitPosition: [
                    "hq": GridCoordinate(row: 1, column: 1),
                    "sq1": GridCoordinate(row: 1, column: 1),
                    "sq2": GridCoordinate(row: 1, column: 2)
                ],
                unitExposed: [],
                unitPinned: []
            )
        )

        let drawing = StubDrawing()

        // 2. Прячем курсор и очищаем экран
        Renderer.hideCursor()
        Renderer.clearScreen()

        // 3. Игровой цикл
        while !state.info.isOver {
            // Отрисовываем информационную панель (верхняя часть экрана)
            Renderer.drawInfoPanel(
                state: state,
                startRow: 1, startCol: 1,
                width: 60, height: 6
            )

            // Отрисовываем панель меню (середина экрана)
            Renderer.drawBox(startRow: 7, startCol: 1, width: 60, height: 4)
            Renderer.drawText("1. Move sq1 to (2,1)", atRow: 8, col: 2, maxWidth: 56)
            Renderer.drawText("2. Finish Phase", atRow: 9, col: 2, maxWidth: 56)

            // Отрисовываем панель ввода (нижняя часть)
            Renderer.drawBox(startRow: 11, startCol: 1, width: 60, height: 3)
            Renderer.drawText("> ", atRow: 12, col: 2, maxWidth: 56)

            // Перемещаем курсор в строку ввода
            Renderer.moveCursorTo(row: 12, col: 4)
            guard let input = readLine() else { break }

            // Обработка ввода
            switch input.trimmingCharacters(in: .whitespaces) {
            case "1":
                state = GameEngine.apply(
                    state: state,
                    action: .movement(.move(id: "sq1", to: GridCoordinate(row: 2, column: 1), generalInitiative: false)),
                    drawing: drawing
                )
            case "2":
                state = GameEngine.apply(
                    state: state,
                    action: .phase(.finish),
                    drawing: drawing
                )
            default:
                // Очищаем панель результата и выводим ошибку
                Renderer.clearPanel(startRow: 14, startCol: 1, width: 60, height: 2)
                Renderer.drawText("Неизвестная команда. Попробуйте снова.", atRow: 15, col: 2, maxWidth: 56)
            }
        }

        // 4. Завершение
        Renderer.showCursor()
        Renderer.clearScreen()
        print("Игра завершена.")
    }
}
