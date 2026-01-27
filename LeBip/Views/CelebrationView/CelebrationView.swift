//
//  CelebrationView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

struct CelebrationView: View {
    @EnvironmentObject var gameState: GameState
    @State private var showConfetti: Bool = true

    var body: some View {
        VStack(spacing: 30) {
            Text("The Winner!")
                .textStyle(TitleTextStyle())
            Spacer()
            if let winner = gameState.winner {
                Text(winner.name)
                    .textStyle(TitleTextStyle())
                    .padding(50)
                    .background(gameState.winner?.color)
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }

            Spacer()

            Button {
                gameState.resetToSetup()
            } label: {
                Text("New Game")
                    .textStyle(TitleTextStyle())
            }
            .buttonStyle(LargeButtonStyle())
        }
        .padding()
        .background(Color(AppColor.bgPrimary))
        .displayConfetti(isActive: $showConfetti)
    }
}

#Preview {
    CelebrationView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ])
        )
}
