// Core/Model/Table/RanoomRange.swift 

struct RandomRange: Codable, Equatable {
    let randomResult: Int // первое число - выпавший результат
    let randomResultUpper: Int
    let upperBound: Int // второе число - из скольки вариантов

    /// Удобный инициализатор из JSON строки "1/2" или "1-3/9"  Может вернуть nil
    init?(string: String) {
        if string.contains("-"), string.contains("/") {
            let parts = string.split(separator: "-")
            let partsRight = parts[1].split(separator: "/")
            guard let first = Int(parts[0]),
                  let second = Int(partsRight[0]),
                  let third = Int(partsRight[1]) else { return nil }
            randomResult = first
            randomResultUpper = second
            upperBound = third
            assert(upperBound >= randomResultUpper, "Ошибка: upperBound меньше randomResultUpper.")
            guard upperBound >= randomResultUpper else { return nil }
        } else if string.contains("/") {
            let parts = string.split(separator: "/")
            guard let first = Int(parts[0]),
                  let second = Int(parts[1]) else { return nil }
            randomResult = first
            randomResultUpper = first
            upperBound = second
            assert(upperBound >= randomResultUpper, "Ошибка: upperBound меньше randomResultUpper.")
            guard upperBound >= randomResultUpper else { return nil }
        } else {
            return nil
        }
    }

    func matches(_ roll: Int) -> Bool {
        return roll >= randomResult && roll <= randomResultUpper && roll <= upperBound
    }

}

