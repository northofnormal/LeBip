//
//  TurnOrderView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

struct TurnOrderView: View {
    @EnvironmentObject var gameState: GameState

    @State private var isShowingGameOverSheet: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("End Game") {
                    isShowingGameOverSheet.toggle()
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
        .sheet(isPresented: $isShowingGameOverSheet) {
            GameOverView()
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
