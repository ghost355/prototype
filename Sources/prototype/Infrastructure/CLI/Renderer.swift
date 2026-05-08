// Renderer.swift

import Foundation

// MARK: - Чистые функции форматирования

enum RendererFormatter {
    /// Возвращает массив строк, представляющих информационную панель (некоторые поля из GameState)
    static func formatInfoPanel(state: GameState) -> [String] {
        var lines: [String] = []
        lines.append("Ход: \(state.info.turn) | Фаза: \(state.info.phase.name)")
        return lines
    }

    /// Возвращает строки для отрисовки рамки (верх, низ, боковина)
    static func formatBox(width: Int, height _: Int) -> (top: String, bottom: String, empty: String) {
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

    static func drawBox(
        startRow: Int, startCol: Int, width: Int, height: Int, color: TextColor = .white
    ) {
        let (top, bottom, empty) = RendererFormatter.formatBox(width: width, height: height)

        moveCursorTo(row: startRow, col: startCol)
        print(RendererFormatter.coloredText(top, color: color), terminator: "")

        for row in 1 ..< height - 1 {
            moveCursorTo(row: startRow + row, col: startCol)
            print(RendererFormatter.coloredText(empty, color: color), terminator: "")
        }

        moveCursorTo(row: startRow + height - 1, col: startCol)
        print(RendererFormatter.coloredText(bottom, color: color), terminator: "")
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
        guard height > 1 else {
            // Для высоты 1 просто очищаем одну строку
            moveCursorTo(row: startRow, col: startCol + 1)
            print(String(repeating: " ", count: width - 2), terminator: "")
            fflush(stdout)
            return
        }

        let emptyLine = String(repeating: " ", count: width - 2)
        for row in 1 ..< height - 1 {
            moveCursorTo(row: startRow + row, col: startCol + 1)
            print(emptyLine, terminator: "")
        }
        fflush(stdout)
    }

    static func drawMessage(
        _ message: String, atRow: Int, col: Int, maxWidth: Int, maxLines: Int = 3,
        color _: TextColor = .white
    ) {
        guard maxWidth > 4 else { return } // минимальная ширина для панели
        let cleaned = message.trimmingCharacters(in: .whitespacesAndNewlines)
        let usableWidth = maxWidth - 4

        // Если сообщение пустое — просто очищаем строки
        guard !cleaned.isEmpty else {
            for i in 0 ..< maxLines {
                moveCursorTo(row: atRow + i, col: col)
                print(String(repeating: " ", count: usableWidth), terminator: "")
            }
            return
        }

        var lines: [String] = []
        var remaining = cleaned

        while !remaining.isEmpty, lines.count < maxLines {
            if remaining.count <= usableWidth {
                lines.append(remaining)
                break
            }

            let splitIndex =
                remaining.index(
                    remaining.startIndex, offsetBy: usableWidth, limitedBy: remaining.endIndex
                )
                ?? remaining.endIndex
            let chunk = String(remaining[..<splitIndex])

            if let lastSpace = chunk.lastIndex(of: " "), lastSpace > chunk.startIndex {
                let breakIndex = chunk.distance(from: chunk.startIndex, to: lastSpace)
                let line = String(chunk[..<chunk.index(chunk.startIndex, offsetBy: breakIndex)])
                lines.append(line)
                let nextStart = chunk.index(chunk.startIndex, offsetBy: breakIndex + 1)
                if nextStart < remaining.endIndex {
                    remaining = String(remaining[nextStart...])
                } else {
                    remaining = ""
                }
            } else {
                lines.append(String(chunk))
                if splitIndex < remaining.endIndex {
                    remaining = String(remaining[splitIndex...])
                } else {
                    remaining = ""
                }
            }
        }

        for (i, line) in lines.enumerated() {
            moveCursorTo(row: atRow + i, col: col)
            let padded = line.padding(toLength: usableWidth, withPad: " ", startingAt: 0)
            print(padded, terminator: "")
        }

        if lines.count < maxLines {
            for i in lines.count ..< maxLines {
                moveCursorTo(row: atRow + i, col: col)
                print(String(repeating: " ", count: usableWidth), terminator: "")
            }
        }
    }

    static func clearMessage(row: Int, col: Int, width: Int, color: TextColor = .white) {
        drawMessage("", atRow: row, col: col, maxWidth: width, color: color)
    }
}

// MARK: - Цветовые модели

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
