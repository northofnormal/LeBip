//
//  PlayerListItemView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

struct PlayerListItemView: View {
    var player: Player

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Circle()
                .fill(player.color)
                .frame(width: 50, height: 50)

            Text(player.name)
                .textStyle(SubTitleTextStyle())

            Spacer()
        }
        .padding()
        .background(Color(AppColor.bgAlt))
    }
}

#Preview {
    PlayerListItemView(player: Player(id: UUID(), name: "Horace", color: AppColor.playerTeal))
}
