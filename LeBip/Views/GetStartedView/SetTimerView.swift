//
//  SetTimerView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

struct SetTimerView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss

    @State private var seconds: Int = 120
    @State private var isEnabled: Bool = true

    let presets = [30, 60, 120, 180, 300]
    let haptic = UISelectionFeedbackGenerator()

    var minutes: Int {
        seconds / 60
    }

    var remainingSeconds: Int {
        seconds % 60
    }

    var body: some View {
        VStack {
            Text("Turn Timer")
                .textStyle(TitleTextStyle())

            Text("Each turn lasts: ")
                .textStyle(BodyTextStyle())

            Text("\(seconds) seconds") 
                .textStyle(BodyTextStyle())

            HStack{
                Picker("Minutes", selection: Binding(
                    get: { minutes },
                    set: { newMinutes in
                        seconds = newMinutes * 60 + remainingSeconds
                    }
                )) {
                    ForEach(0..<10) {
                        Text("\($0) min")
                            .foregroundStyle(AppColor.textSecondary) }
                }
                .pickerStyle(.wheel)

                Picker("Seconds", selection: Binding(
                    get: { remainingSeconds },
                    set: { newSeconds in
                        seconds = minutes * 60 + newSeconds
                    }
                )) {
                    ForEach(Array(stride(from: 0, to: 60, by: 5)), id: \.self) {
                        Text("\($0) sec")
                            .foregroundStyle(AppColor.textSecondary)
                    }
                }
                .pickerStyle(.wheel)
            }

            Button {
                gameState.setTurnDuration(TimeInterval(seconds))
                dismiss() 
            } label: {
                Text("Save")
                    .textStyle(SubTitleTextStyle())
            }
            .buttonStyle(PillButtonStyle())

        }
        .padding()
        .background(AppColor.bgAlt)
        .onAppear {
            haptic.prepare()
        }
    }
}

#Preview {
    SetTimerView()
        .environmentObject(
            GameState(players: [
                Player(id: UUID(), name: "Horace", color: AppColor.playerMustard),
                Player(id: UUID(), name: "Aisha", color: AppColor.playerGrape)
            ])
        )
}
