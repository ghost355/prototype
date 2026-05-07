// Renderer.swift

import Foundation

// MARK: - Чистые функции форматирования

enum RendererFormatter {
    /// Возвращает массив строк, представляющих информационную панель
    static func formatInfoPanel(state: GameState) -> [String] {
        var lines: [String] = []
        lines.append("Ход: \(state.info.turn) | Фаза: \(state.info.phase.name)")
        lines.append("Команд доступно: \(state.info.availableCommand)")
        lines.append("Команд сохранено: \(state.info.savedCommand)")
        lines.append(
            "Exposed: \(state.unitState.unitExposed.map { String($0) }.joined(separator: ", "))"
        )
        return lines
    }

    /// Возвращает строки для отрисовки рамки (верх, низ, боковина)
    static func formatBox(width: Int, height _: Int) -> (top: String, bottom: String, empty: String)
    {
        let top = "┌" + String(repeating: "─", count: width - 2) + "┐"
        let bottom = "└" + String(repeating: "─", count: width - 2) + "┘"
        let empty = "│" + String(repeating: " ", count: width - 2) + "│"
        return (top, bottom, empty)
    }

    /// Форматирует строку с ANSI-цветами (чистая, не печатает)
    static func coloredText(
        _ text: String,
        color: TextColor = .white,
        background: BgColor? = nil,
        style: TextStyle? = nil
    ) -> String {
        var codes: [Int] = []
        if let style = style { codes.append(style.rawValue) }
        codes.append(color.rawValue)
        if let bg = background { codes.append(bg.rawValue) }
        let codeString = codes.map(String.init).joined(separator: ";")
        return "\u{001B}[\(codeString)m\(text)\u{001B}[0m"
    }
}

// MARK: - Нечистые функции вывода

enum Renderer {
    static func clearScreen() {
        print("\u{001B}[2J\u{001B}[H", terminator: "")
    }

    static func moveCursorTo(row: Int, col: Int) {
        print("\u{001B}[\(row);\(col)H", terminator: "")
    }

    static func hideCursor() {
        print("\u{001B}[?25l", terminator: "")
    }

    static func showCursor() {
        print("\u{001B}[?25h", terminator: "")
    }

    static func drawBox(startRow: Int, startCol: Int, width: Int, height: Int) {
        let (top, bottom, empty) = RendererFormatter.formatBox(width: width, height: height)

        moveCursorTo(row: startRow, col: startCol)
        print(top, terminator: "")

        for row in 1..<height - 1 {
            moveCursorTo(row: startRow + row, col: startCol)
            print(empty, terminator: "")
        }

        moveCursorTo(row: startRow + height - 1, col: startCol)
        print(bottom, terminator: "")
    }

    static func drawText(
        _ text: String, atRow row: Int, col: Int, maxWidth: Int,
        color: TextColor = .white
    ) {
        moveCursorTo(row: row, col: col)
        let truncated = String(text.prefix(maxWidth))
        print(RendererFormatter.coloredText(truncated, color: color), terminator: "")
    }

    static func drawInfoPanel(
        state: GameState, startRow: Int, startCol: Int, width: Int, height: Int
    ) {
        drawBox(startRow: startRow, startCol: startCol, width: width, height: height)

        let lines = RendererFormatter.formatInfoPanel(state: state)
        for (i, line) in lines.enumerated() {
            drawText(line, atRow: startRow + 1 + i, col: startCol + 2, maxWidth: width - 4)
        }
    }

    static func clearPanel(startRow: Int, startCol: Int, width: Int, height: Int) {
        let emptyLine = String(repeating: " ", count: width - 2)
        for row in 1..<height - 1 {
            moveCursorTo(row: startRow + row, col: startCol + 1)
            print(emptyLine, terminator: "")
        }
        fflush(stdout)
    }
}

// MARK: - Цветовые модели (остаются неизменными)

enum TextColor: Int {
    case black = 30
    case red = 31
    case green = 32
    case yellow = 33
    case blue = 34
    case magenta = 35
    case cyan = 36
    case white = 37
    case reset = 0
}

enum BgColor: Int {
    case black = 40
    case red = 41
    case green = 42
    case yellow = 43
    case blue = 44
    case magenta = 45
    case cyan = 46
    case white = 47
}

enum TextStyle: Int {
    case bold = 1
    case dim = 2
    case italic = 3
    case underline = 4
    case reset = 0
}
