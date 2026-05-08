// CLIHelpers.swift

import Foundation

/// Выбор из списка вариантов
func chooseFromMenu<T>(
    title: String,
    items: [T],
    display: (T) -> String = { "\($0)" }
) -> T? {
    guard !items.isEmpty else {
        print("Нет доступных вариантов")
        return nil
    }
    print(title)
    for (index, item) in items.enumerated() {
        print("\(index + 1). \(display(item))")
    }
    print("Ваш выбор: ", terminator: "")
    guard let input = readLine(),
        let choice = Int(input),
        choice >= 1 && choice <= items.count
    else {
        print("Неверный ввод")
        return nil
    }
    return items[choice - 1]
}

func unitDescription(state: GameState, unitID: UnitID) -> String {
    guard state.units[unitID] != nil,
        let pos = state.unitState.unitPosition[unitID]
    else {
        return "\(unitID)(??)"
    }
    return "\(unitID)(\(pos.row),\(pos.column))"
}
