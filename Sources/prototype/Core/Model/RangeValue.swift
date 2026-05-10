// Core/Model/RangeValue.swift

struct RangeValue: Codable, Equatable {
    let requiredRoll: Int    // первое число (например, 1 или 4)
    let upperBound: Int      // второе число (например, 2 или 9)
    
    // Удобный инициализатор из JSON строки "1/2" или "4/9"
    init?(string: String) {
        let parts = string.split(separator: "/")
        guard parts.count == 2,
              let first = Int(parts[0]),
              let second = Int(parts[1]) else { return nil }
        self.requiredRoll = first
        self.upperBound = second
    }
    
    // Проверяет, попадает ли сгенерированное число в диапазон
    func matches(roll: Int) -> Bool {
        return roll >= requiredRoll && roll <= upperBound
    }
}
