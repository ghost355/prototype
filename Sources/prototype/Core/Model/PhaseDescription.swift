/// Core/PhaseDescriptor.swift
struct PhaseDescriptor {
    let name: String
    let isInteractive: Bool
    let execute: (GameState, ActionCardDrawing) -> GameState
}
