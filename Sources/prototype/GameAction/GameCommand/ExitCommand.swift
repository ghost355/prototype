// ExitCommand.swift

enum ExitCommand {
    static func execute(state: GameState) -> GameState {
        let info = state.info.copy(isGameRunning: false)
        return state.copy(info: info)
    }
}
