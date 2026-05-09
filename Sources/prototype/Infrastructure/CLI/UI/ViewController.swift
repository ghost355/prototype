// Infrastructure/CLI/UI/ViewController.swift
import Foundation

enum ViewController {
    static func initializeUI(state: GameState) {
        Renderer.clearScreen()
        Renderer.hideCursor()

        Renderer.drawBox(
            startRow: LayoutConstants.infoRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.infoHeight)
        Renderer.drawBox(
            startRow: LayoutConstants.menuRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.menuHeight)
        Renderer.drawBox(
            startRow: LayoutConstants.inputRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.inputHeight)
        Renderer.drawText(
            "> ", atRow: LayoutConstants.inputRow + 1, col: LayoutConstants.startCol + 2,
            maxWidth: LayoutConstants.panelWidth - 4)
        Renderer.drawBox(
            startRow: LayoutConstants.helpRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.helpHeight)
    }

    static func showInfo(textLines: [String]) {
        Renderer.clearPanel(
            startRow: LayoutConstants.infoRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.infoHeight)
        for (num, line) in textLines.enumerated() {
            Renderer.drawText(
                line, atRow: LayoutConstants.infoRow + 1 + num,
                col: LayoutConstants.startCol + 2, maxWidth: LayoutConstants.panelWidth - 4,
                color: .cyan)
        }
    }

    static func showContextMenu(
        for context: GameLoop.MenuContext, state: GameState, errorMessage: inout String?
    ) {
        let items = MenuText.items(for: context, state: state)
        let helpText = errorMessage ?? MenuText.help(for: context)

        Renderer.clearPanel(
            startRow: LayoutConstants.menuRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.menuHeight)
        for (index, item) in items.enumerated() {
            Renderer.drawText(
                "\(index + 1). \(item)",
                atRow: LayoutConstants.menuRow + 1 + index,
                col: LayoutConstants.startCol + 2, maxWidth: LayoutConstants.panelWidth - 4,
                color: .red)
        }

        Renderer.clearPanel(
            startRow: LayoutConstants.helpRow, startCol: LayoutConstants.startCol,
            width: LayoutConstants.panelWidth, height: LayoutConstants.helpHeight)
        Renderer.drawText(
            helpText, atRow: LayoutConstants.helpRow + 1,
            col: LayoutConstants.startCol + 2, maxWidth: LayoutConstants.panelWidth - 4)
        errorMessage = nil
    }

    static func clearInputPanel() {
        Renderer.clearPanel(
            startRow: LayoutConstants.inputRow + 1, startCol: LayoutConstants.startCol + 2,
            width: LayoutConstants.panelWidth - 4, height: 1)
        Renderer.drawText(
            "> ", atRow: LayoutConstants.inputRow + 1, col: LayoutConstants.startCol + 2,
            maxWidth: LayoutConstants.panelWidth - 4)
    }
}
