// Infrastructure/CLI/UI/LayoutConstants.swift
import Foundation

enum LayoutConstants {
    // Сетка
    static let startCol = 1
    static let panelWidth = 140

    // Высоты панелей (можно регулировать)
    static let infoHeight = 10
    static let menuHeight = 15
    static let inputHeight = 3
    static let helpHeight = 6

    // Вычисляемые позиции (чтобы не считать вручную)
    static let infoRow = 1
    static let menuRow = infoRow + infoHeight
    static let inputRow = menuRow + menuHeight
    static let helpRow = inputRow + inputHeight

    // Цвета (дублируем сюда для удобства, или оставить ссылки на TextColor)
    // Пока оставим так, потом можно вынести в ColorPalette
}
