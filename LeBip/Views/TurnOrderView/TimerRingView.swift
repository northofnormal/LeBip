//
//  TimerRingView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/24/26.
//

import SwiftUI

struct TimerRingView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12)
                .opacity(0.2)

            Circle() // make this one a color
                .trim(from: 0, to: gameState.progress ?? 0.0)
                .stroke(style: StrokeStyle(
                    lineWidth: 12,
                    lineCap: .round
                ))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: gameState.progress)
        }
    }
}

