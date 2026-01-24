//
//  GameOverView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/23/26.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss

    @State private var shouldDismiss: Bool = true

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Game Over!")
                .textStyle(TitleTextStyle())

            VStack(spacing: 0) {
                Text("Who won?")
                    .textStyle(BodyTextStyle())
                PlayerListView(shouldDismiss: $shouldDismiss, selectionEnabled: true)
            }

            Spacer()
        }
        .padding()
        .background(AppColor.bgPrimary)
        .onChange(of: shouldDismiss) { _, newValue in
            if newValue == true {
                dismiss()
            }
        }
    }
}

#Preview {
    GameOverView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ],
                      turnDuration: 60)
        )
}
