//
//  ChooseFirstPlayerView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

struct ChooseFirstPlayerView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss

    @State private var flippedCards: Set<UUID> = []
    @State private var winner: UUID? = nil
    @State private var celebrateWinner: Bool = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(gameState.players) { player in
                    PlayerCardView(
                        player: player,
                        isFlipped: flippedCards.contains(player.id),
                        isWinner: winner == player.id,
                        celebrate: celebrateWinner
                    )
                }
            }

            Spacer()

            if !celebrateWinner {
                Button {
                    Task {
                        await revealWinner()
                    }
                } label: {
                    Text("Select First Player")
                        .textStyle(HeadlineTextStyle())
                        .multilineTextAlignment(.center)
                }
                .buttonStyle(LargeButtonStyle())
            } else {
                Button {
                    gameState.startGame()
                    dismiss()
                } label: {
                    Text("Start Game")
                        .textStyle(HeadlineTextStyle())
                }
                .buttonStyle(LargeButtonStyle())
            }



        }
        .padding(20)
        .background(Color(AppColor.bgPrimary))

    }

    func revealWinner() async {
        // Flip all cards one by one
        for player in gameState.players.shuffled() {
            flippedCards.insert(player.id)
            try? await Task.sleep(nanoseconds: 200_000_000) // 0.2s
        }

        // Pick winner
        if let chosen = gameState.players.randomElement()?.id {
            winner = chosen
            // ensure winner is flipped (in case)
            flippedCards.insert(chosen)
        }

        // Small dramatic pause…
        try? await Task.sleep(nanoseconds: 300_000_000)

        // 🎉 POP
        withAnimation {
            celebrateWinner = true
        }

        if let winnerID = winner {
            gameState.setFirstPlayer(id: winnerID)
        }
    }

}


#Preview {
    ChooseFirstPlayerView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape),
                Player(id: UUID(), name: "Lola", color: AppColor.playerRose)
            ],
                      turnDuration: 60)
        )
}
