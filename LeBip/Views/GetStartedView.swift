//
//  GetStartedView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

struct GetStartedView: View {
    @EnvironmentObject var gameState: GameState

    @State var isShowingTimerSheet: Bool = false
    @State private var sheetHeight: CGFloat = .zero

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Let's play!")
                    .textStyle(TitleTextStyle())

                NavigationLink(destination: SetPlayersView()) {
                    Text("AddPlayers")
                        .textStyle(SubTitleTextStyle())
                }
                .buttonStyle(PillButtonStyle())

                if !gameState.players.isEmpty {
                    PlayerListView(shouldDismiss: .constant(false))
                        .frame(height: 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 3)
                        )
                }

                Toggle(isOn: $isShowingTimerSheet) {
                    Text("Timed turns?")
                        .textStyle(HeadlineTextStyle())
                }
                .tint(AppColor.playerRose)

                VStack(spacing: 5) {
                    if !gameState.players.isEmpty {
                        Button {
                            gameState.gamePhase = .choosingFirst
                        } label: {
                            Text("Choose First Player")
                                .textStyle(SubTitleTextStyle())
                        }
                        .buttonStyle(PillButtonStyle())
                        Text("Randomly set a first player, or go with the order above")
                            .textStyle(BodyTextStyle())
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                Spacer()
                
                Button {
                    gameState.startGame()
                } label: {
                    Text("Start Game")
                        .textStyle(TitleTextStyle())
                }
                .buttonStyle(LargeButtonStyle())
            }
            .padding()
            .sheet(isPresented: $isShowingTimerSheet) {
                SetTimerView()
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
}

#Preview {
    GetStartedView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ],
                      turnDuration: 60)
        )
}

