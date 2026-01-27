//
//  PlayerTurnView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

struct PlayerTurnView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        ZStack {
            if gameState.turnDuration != nil {
                TimerRingView()
                    .id(gameState.turnID)
            }

            VStack(spacing: 8) {
                Text(gameState.currentPlayer?.name ?? "")
                    .textStyle(TitleTextStyle())

                if gameState.turnDuration != nil {
                    Button {
                        if gameState.timerStatus == .running {
                            gameState.pauseTimer()
                        } else if gameState.timerStatus == .paused {
                            gameState.resumeTimer()
                        }
                    } label: {
                        Image(systemName: gameState.timerStatus == .running
                              ? "pause.fill"
                              : "play.fill")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .tint(AppColor.textSecondary)
                    }
                }
            }
        }
        .frame(width: 240, height: 240)
        .padding(20)
        .background(Color(gameState.currentPlayer?.color ?? Color.clear))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 3)
        )
    }
}

#Preview {
    PlayerTurnView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ])
        )
}
