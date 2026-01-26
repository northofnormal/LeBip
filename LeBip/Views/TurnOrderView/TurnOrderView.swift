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

    @State private var shouldDismiss: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("End Game") {
                    gameState.endGame() 
                }
                .buttonStyle(.glass)
                .tint(AppColor.textSecondary)
            }

            Text("Current Turn")
                .textStyle(TitleTextStyle())

            Spacer()

            PlayerTurnView()


            Text("Next up...")
                .textStyle(SubTitleTextStyle())

            VStack {
                PlayerListItemView(player: gameState.nextPlayer)
                PlayerListItemView(player: gameState.nextNextPlayer)
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
        .background(Color(AppColor.bgPrimary))
        .onChange(of: shouldDismiss) { _, newValue in
            if newValue == true {
                dismiss()
            }
        }

    }
}

#Preview {
    TurnOrderView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ],
                      turnDuration: 60)
        )
}
