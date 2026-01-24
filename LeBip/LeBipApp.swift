//
//  LeBipApp.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

@main
struct LeBipApp: App {
    @StateObject private var gameState: GameState = GameState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(gameState)
        }
    }
}
