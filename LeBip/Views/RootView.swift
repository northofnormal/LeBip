//
//  RootView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        switch gameState.gamePhase {
        case .setup:
            GetStartedView()
        case .choosingFirst:
            ChooseFirstPlayerView()
        case .inGame:
            TurnOrderView()
        case .gameOver:
            GameOverView()
        case .celebrate:
            CelebrationView()
        }
    }
}
