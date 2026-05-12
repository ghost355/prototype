// Infrastructure/CLI/UI/MenuText.swift
import Foundation

typealias MenuItem = (title: String, action: () -> Void)

enum MenuContext {
    case main
}

enum MenuText {
    static func items(
        for appContext: GameLoop.AppContext,
        menuContext: MenuContext,
        state _: GameState,
        onStartGame: @escaping () -> Void,
        onExit: @escaping () -> Void
    ) -> [MenuItem] {
        switch (appContext, menuContext) {
        case (.mainMenu, .main):
            return [
                ("Начать игру", onStartGame),
                ("Выход", onExit),
            ]
        case (.game, .main):
            return []
        default: return []
        }
    }

    static func help(for appContext: GameLoop.AppContext, menuContext: MenuContext) -> String {
        switch (appContext, menuContext) {
        case (.mainMenu, .main):
            return "Главное меню. Введите номер пункта меню и нажмите Enter"
        default: return ""
        }
    }

    static func info(
        for appContext: GameLoop.AppContext, menuContext: MenuContext, state _: GameState, phaseName _: String? = nil
    )
        -> [String]
    {
        switch (appContext, menuContext) {
        case (.mainMenu, .main):
            return [
                "", "", "",
                "\t\t\t\t\t\t FIELDS OF FIRE DELUXE - The digital edition".color(
                    .yellow, style: .bold
                ),
            ]
        default: return [""]
        }
    }
}
