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
            if let progress = gameState.progress {
                TimerRingView(progress: progress)
                    .id(gameState.turnID)
            }

            VStack(spacing: 8) {
                Text(gameState.currentPlayer.name)
                    .textStyle(TitleTextStyle())
            }
        }
        .frame(width: 240, height: 240)
        .padding(20)
        .background(Color(gameState.currentPlayer.color))
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
            ],
                      turnDuration: 60)
        )
}


struct TimerRingView: View {
    let progress: TimeInterval

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12)
                .opacity(0.2)

            Circle() // make this one a color
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(
                    lineWidth: 12,
                    lineCap: .round
                ))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: progress)
        }
    }
}
