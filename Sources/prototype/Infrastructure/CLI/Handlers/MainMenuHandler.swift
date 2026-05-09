// Infrastructure/CLI/Handlers/MainMenuHandler.swift
import Foundation

enum MainMenuHandler {
    static func handle(
        choice: Int,
        context: inout GameLoop.MenuContext,
        state: inout GameState,
        drawing: ActionCardDrawing
    ) {
        switch choice {
        case 1:
            state = GameEngine.apply(state: state, action: .phase(.finish), drawing: drawing)
        case 2:
            context = .demo
        case 3:
            state = GameEngine.apply(state: state, action: .game(.exit), drawing: drawing)
        default:
            break
        }
    }
}
