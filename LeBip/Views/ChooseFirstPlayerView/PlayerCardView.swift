//
//  PlayerCardView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/24/26.
//

import SwiftUI

struct PlayerCardView: View {
    let player: Player
    let isFlipped: Bool
    let isWinner: Bool
    let celebrate: Bool

    var body: some View {
        ZStack {
            // Back of Card
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColor.playerCoral)
                .overlay(Image(systemName: "person").font(.largeTitle))

            // Front of Card
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(player.color))
                .overlay(Text(player.name).bold())
                .opacity(isFlipped ? 1 : 0)
        }
        .frame(width: 100, height: 140)
        .rotation3DEffect(
            .degrees(isFlipped ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(celebrate && isWinner ? 0.8 : 0), lineWidth: 3)
        )
        .scaleEffect(celebrate && isWinner ? 1.15 : 1.0)
        .shadow(radius: celebrate && isWinner ? 10 : 3)
        .animation(.spring(response: 0.45, dampingFraction: 0.65), value: celebrate)
        .animation(.easeInOut(duration: 0.5), value: isFlipped)

    }
}
