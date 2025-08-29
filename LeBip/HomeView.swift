//
//  HomeView.swift
//  LeBip
//
//  Created by Anne Cahalan on 8/29/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isShowingInstructions = true

    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(Color.player1)
                    .aspectRatio(1.0, contentMode: .fill)
                    .frame(maxWidth: .infinity)

                Spacer()
                    .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color.player2)
                    .aspectRatio(1.0, contentMode: .fill)
                    .frame(maxWidth: .infinity)
            }

            HStack {
                Rectangle()
                    .fill(Color.player3)
                    .aspectRatio(1.0, contentMode: .fill)

                Spacer()

                Rectangle()
                    .fill(Color.player4)
                    .aspectRatio(1.0, contentMode: .fill)
            }
            .fixedSize(horizontal: true, vertical: false)

            HStack {
                Rectangle()
                    .fill(Color.player5)
                    .aspectRatio(1.0, contentMode: .fill)

                Spacer()

                Rectangle()
                    .fill(Color.player6)
                    .aspectRatio(1.0, contentMode: .fill)
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isShowingInstructions) {
           InstructionView()
                .presentationBackground(.backgroundFade)
                .onDisappear {
                    isShowingInstructions = false
                }
       }
    }
}

#Preview {
    HomeView()
}
