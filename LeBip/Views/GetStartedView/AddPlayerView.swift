//
//  AddPlayerView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

struct AddPlayerView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss

    @State private var selectedColor: Color = AppColor.playerCoral
    @State private var playerName: String = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Player Name", text: $playerName)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
            ColorPickerView(selectedColor: $selectedColor)

            HStack {
                Button {
                   let player = Player(id: UUID(), name: playerName, color: selectedColor)
                    gameState.add(player: player)
                    playerName = ""
                    selectedColor = AppColor.playerBlue
                } label: {
                    Label("Save & Add Another", systemImage: "person.2.fill")
                        .foregroundStyle(AppColor.textSecondary)
                }
                .buttonStyle(PillButtonStyle())
                .disabled(playerName == "")

                Button {
                    let player = Player(id: UUID(), name: playerName, color: selectedColor)
                    gameState.add(player: player)
                    dismiss()
                } label: {
                    Label("Save Player", systemImage: "person.fill.badge.plus")
                        .foregroundStyle(AppColor.textSecondary)
                }
                .buttonStyle(PillButtonStyle())
                .disabled(playerName == "")
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color(AppColor.bgAlt))
    }
}

#Preview {
    AddPlayerView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ],
                      turnDuration: 60)
        )
}
