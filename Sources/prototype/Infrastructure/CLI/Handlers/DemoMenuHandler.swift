// Infrastructure/CLI/Handlers/DemoMenuHandler.swift
import Foundation

enum DemoMenuHandler {
    static func handle(
        choice: Int,
        context: inout GameLoop.MenuContext,
        state: inout GameState,
        drawing: ActionCardDrawing
    ) {
        switch choice {
        case 1:
            // Действие для "Раздел 1" — пока ничего
            break
        case 2:
            // Действие для "Раздел 2" — пока ничего
            break
        default:
            break
        }
    }
}
