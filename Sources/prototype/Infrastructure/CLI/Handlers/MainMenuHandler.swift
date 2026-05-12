// Infrastructure/CLI/Handlers/MainMenuHandler.swift
import Foundation

enum MainMenuHandler {
    static func handle(
        choice: Int,
        menuContext: inout MenuContext,
        appContext: inout GameLoop.AppContext,
        state: inout GameState,
        drawing: ActionCardDrawing
    ) {
        switch choice {
        case 1:
            appContext = .game
        default:
            break
        }
    }
}
