// Core/GameTables/HQEventTable.swift

struct HQEventTable: Codable {
    let diceSides: Int
    let events: [HQEventEntry]

    func resolveEvent(turn: Int, roll: Int) -> String? {
        for event in events {
            for slot in event.slots {
                if slot.matches(turn: turn), let range = slot.range, range.matches(roll: roll) {
                    return event.name
                }
            }
        }
        return nil
    }
}
