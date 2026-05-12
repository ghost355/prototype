import Foundation

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

// MARK: - Низкоуровневый рендерер (только примитивы)

enum Renderer {
    // MARK: - Управление экраном и курсором

    static func clearScreen() {
        print("\u{001B}[2J\u{001B}[H", terminator: "")
        fflush(stdout)
    }

    static func hideCursor() {
        print("\u{001B}[?25l", terminator: "")
        fflush(stdout)
    }

    static func showCursor() {
        print("\u{001B}[?25h", terminator: "")
        fflush(stdout)
    }

    static func moveCursorTo(row: Int, col: Int) {
        print("\u{001B}[\(row);\(col)H", terminator: "")
        fflush(stdout)
    }

    // MARK: - Цветное форматирование строки (чистая функция)

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

    // MARK: - Примитивы рисования

    /// Рисует прямоугольную рамку указанного цвета.
    static func drawBox(
        startRow: Int,
        startCol: Int,
        width: Int,
        height: Int,
        color: TextColor = .white
    ) {

        guard width >= 2, height >= 2 else { return }

        let top = "┌" + String(repeating: "─", count: width - 2) + "┐"
        let bottom = "└" + String(repeating: "─", count: width - 2) + "┘"
        let empty = "│" + String(repeating: " ", count: width - 2) + "│"

        moveCursorTo(row: startRow, col: startCol)
        print(coloredText(top, color: color), terminator: "")

        for row in 1..<height - 1 {
            moveCursorTo(row: startRow + row, col: startCol)
            print(coloredText(empty, color: color), terminator: "")
        }

        moveCursorTo(row: startRow + height - 1, col: startCol)
        print(coloredText(bottom, color: color), terminator: "")
        fflush(stdout)
    }

    /// Очищает внутреннюю область прямоугольника (рамка не трогается).
    static func clearPanel(
        startRow: Int,
        startCol: Int,
        width: Int,
        height: Int
    ) {
        guard height >= 1, width > 2 else { return }

        // если высота = 1, просто очищаем одну строку внутри рамки
        if height == 1 {
            moveCursorTo(row: startRow, col: startCol + 1)
            print(String(repeating: " ", count: width - 2), terminator: "")
            fflush(stdout)
            return
        }

        guard height > 2 else { return }  // для высоты 2 нет внутренней области

        let emptyLine = String(repeating: " ", count: width - 2)
        for row in 1..<height - 1 {
            moveCursorTo(row: startRow + row, col: startCol + 1)
            print(emptyLine, terminator: "")
        }
        fflush(stdout)
    }
    /// Выводит текст в указанной позиции, обрезая до maxWidth.
    static func drawText(
        _ text: String,
        atRow row: Int,
        col: Int,
        maxWidth: Int,
        color: TextColor = .white
    ) {

        moveCursorTo(row: row, col: col)
        let truncated = String(text.prefix(maxWidth))
        print(coloredText(truncated, color: color), terminator: "")
        fflush(stdout)
    }
}


extension String {
    /// Оборачивает строку в ANSI-код указанного цвета.
    func color(_ color: TextColor, background: BgColor? = nil, style: TextStyle? = nil) -> String {
        Renderer.coloredText(self, color: color, background: background, style: style)
    }

    /// Оборачивает строку в ANSI-код указанного стиля (без изменения цвета).
    func style(_ style: TextStyle) -> String {
        // Передаём цвет по умолчанию (.white), чтобы не менять уже установленный цвет.
        Renderer.coloredText(self, color: .white, style: style)
    }

    /// Сбрасывает все стили и цвета до стандартных.
    func reset() -> String {
        Renderer.coloredText(self, color: .reset, style: .reset)
    }
}
