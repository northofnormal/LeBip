//
//  InstructionView.swift
//  LeBip
//
//  Created by Anne Cahalan on 8/29/25.
//

import SwiftUI

struct InstructionView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 25) {
                Text("Instructions")
                    .font(.largeTitle)
                    .foregroundStyle(Color.black)
                Text("1. Each player tap on their color in turn order.")
                    .font(.title2)
                    .foregroundStyle(Color.black)
                Text("2. Selected colors will flash after 5 seconds.")
                    .font(.title2)
                    .foregroundStyle(Color.black)
                Text("3. If all is correct, hit continue to start playing!")
                    .font(.title2)
                    .foregroundStyle(Color.black)

                Button("Let's do it!") {
                    dismiss()
                }
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.player4)
                .clipShape(Capsule())
            }
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 8)
            )
            .padding()

            Spacer()
        }
        .background(Color.clear)
    }
}

#Preview {
    InstructionView()
}

