// CommandState.swift

struct CommandState: Codable, Equatable {
    let activated: Int
    let saved: Int
    let isActivated: Bool

    init(activated: Int = 0, saved: Int = 0, isActivated: Bool = false) {
        self.activated = activated
        self.saved = saved
        self.isActivated = isActivated
    }

    func copy(activated: Int? = nil, saved: Int? = nil, isActivated: Bool? = nil) -> Self {
        Self(
            activated: activated ?? self.activated,
            saved: saved ?? self.saved,
            isActivated: isActivated ?? self.isActivated)
    }
}
