//
//  TurnOrderView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

struct TurnOrderView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss

    @State var showAlert: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("End Game") {
                    showAlert.toggle()
                }
                .buttonStyle(.glass)
                .tint(AppColor.textSecondary)
            }

            Text(gameState.timeExpired ? "Time Expired" : "Current Turn")
                .textStyle(TitleTextStyle())

            Spacer()

            PlayerTurnView()


            Text("Next up...")
                .textStyle(SubTitleTextStyle())

            VStack {
                ForEach(gameState.upcomingPlayers(count: 2)) { player in
                    PlayerListItemView(player: player)
                }
            }

            Spacer()

            Button {
                withAnimation {
                    gameState.endTurn()
                }
            } label: {
                Text("End Turn")
                    .textStyle(TitleTextStyle())
            }
            .buttonStyle(LargeButtonStyle())
        }
        .padding()
        .background(gameState.timeExpired ? Color.red : AppColor.bgPrimary)
        .onChange(of: gameState.timeExpired) { _, expired in
            guard expired else { return }
            let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.prepare()
                generator.impactOccurred()
        }
        .alert("Are you sure?", isPresented: $showAlert, actions: {
            Button(role: .destructive) {
                gameState.endGame()
            } label: {
                Text("Game Over")
            }
            Button("Cancel", role: .cancel) { }
        }, message: {
            Text("Are you sure you want to end the game?")
        })

    }
}

#Preview {
    TurnOrderView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ])
        )
}
