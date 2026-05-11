import Foundation

@testable import prototype

/// Глобальная точка входа
@main
struct GameApp {
    static func main() {
        // MARK: - Заглушки, пока нет Setup

        let info = GameInfo(
            missionType: .offensive,
            turn: 1,
            maxTurns: 3,
            phase: .friendlyHQEvent,
            isGameRunning: true
        )

        let map = Map(
            rows: 3,
            columns: 3
        )
        let units: [String: prototype.Unit] = [:]  // уточняем тип для избежания неоднозначности
        let unitState = UnitState(
            unitPosition: [:],
            unitExposed: [],
            unitPinned: [],
            commandState: [:]
        )

        let table: HQEventTable = loadJSON("hqEvent", as: HQEventTable.self, from: .module)

        let initialState = GameState(
            map: map,
            info: info,
            units: units,
            unitState: unitState,
            debugMessage: "Нет сообщений",
            table: table
        )

        let drawing = ActionDeck()

        GameLoop.run(initialState: initialState, drawing: drawing)
    }
}
