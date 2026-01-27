//
//  PlayerListView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/23/26.
//

import SwiftUI

struct PlayerListView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss

    @State private var selectedPlayer: Player? = nil

    @Binding var shouldDismiss: Bool

    public var selectionEnabled: Bool = false

    var body: some View {
        List(selection: $selectedPlayer) {
            ForEach(gameState.players) { player in
                PlayerListItemView(player: player)
                    .tag(player)
                    .listRowInsets(.all, .zero)
                    .listRowBackground(
                        editMode?.wrappedValue == .active ? AppColor.bgAlt.opacity(0.3) : Color.clear
                    )
            }
            .onDelete(perform: gameState.removePlayer)
            .onMove(perform: gameState.movePlayers)
        }
        .selectionDisabled(!selectionEnabled)
        .background(AppColor.bgPrimary)
        .scrollContentBackground(.hidden)
        .onChange(of: selectedPlayer) { oldValue, newValue in
            if selectionEnabled, let winner = newValue {
                gameState.setWinner(winner)
                shouldDismiss = true
                dismiss() 
            }
        }
    }
}

#Preview {
    PlayerListView(shouldDismiss: .constant(false))
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ])
        )
}
