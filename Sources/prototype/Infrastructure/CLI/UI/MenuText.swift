// Infrastructure/CLI/UI/MenuText.swift
import Foundation

enum MenuContext {
    case main
}

enum MenuText {
    static func items(
        for appContext: GameLoop.AppContext, menuContext: MenuContext, state _: GameState
    ) -> [String] {
        switch (appContext, menuContext) {
        case (.mainMenu, .main): return ["Начать игру"]
        default: return [""]
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
        for appContext: GameLoop.AppContext, menuContext: MenuContext, state: GameState
    )
        -> [String]
    {
        switch (appContext, menuContext) {
        case (.mainMenu, .main):
            return [
                "", "", "",
                "\t\t\t\t\t\t FIELDS OF FIRE DELUXE - The digital edition".color(
                    .yellow, style: .bold),
            ]
        default: return [""]
        }
    }
}
