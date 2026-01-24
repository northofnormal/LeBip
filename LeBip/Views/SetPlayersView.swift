//
//  SetPlayersView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

struct SetPlayersView: View {
    @EnvironmentObject var gameState: GameState

    @State private var isShowingAddView: Bool = false
    @State private var editMode: EditMode = .active
    @State private var sheetHeight: CGFloat = .zero

    var body: some View {
        VStack {
            Text("Players")
                .textStyle(TitleTextStyle())

            if gameState.players.isEmpty {
                Spacer()
                EmptyPlayersView()
                Spacer()
            }

            if !gameState.players.isEmpty {
                PlayerListView(shouldDismiss: .constant(false))
            }

            Button {
                isShowingAddView.toggle()
            } label: {
                Text("Add A Player")
                    .textStyle(SubTitleTextStyle())

            }
            .buttonStyle(PillButtonStyle())
        }
        .padding()
        .toolbar {
            EditButton()
                .tint(AppColor.textSecondary)
        }
        .sheet(isPresented: $isShowingAddView) {
            AddPlayerView()
                .fixedSize(horizontal: false, vertical: true)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.size.height
                } action: { newValue in
                    sheetHeight = newValue
                }
                .presentationDetents([.height(sheetHeight)])

        }
        .background(Color(AppColor.bgPrimary))
    }
}

#Preview {
    SetPlayersView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ],
                      turnDuration: 60)
        )
}

