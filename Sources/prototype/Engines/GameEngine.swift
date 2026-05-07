// GameEngine.swift

enum GameEngine {
    static func apply(state: GameState, action: GameAction, drawing: ActionCardDrawing) -> GameState
    {

        switch action {

        case let .phase(action):
            return PhaseHandler.execute(state: state, action: action, drawing: drawing)

        case let .movement(action):
            return MovementHandler.execute(state: state, action: action, drawing: drawing)

        case let .combat(action):
            return CombatHandler.execute(state: state, action: action, drawing: drawing)

        case let .control(action):
            return ControlHandler.execute(state: state, action: action, drawing: drawing)

        case let .rally(action):
            return RallyHandler.execute(state: state, action: action, drawing: drawing)

        case let .enemy(action):
            return EnemyHandler.execute(state: state, action: action, drawing: drawing)
        }
    }
}
