//
//  ConfettiContainerView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/24/26.
//

import SwiftUI

struct ConfettiContainerView: View {
    var count: Int = 100
    @State private var ySeed: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<count, id: \.self) { _ in
                    ConfettiView()
                        .position(
                            x: CGFloat.random(in: 0...geo.size.width),
                            y: ySeed == 0 ? 0 : CGFloat.random(in: 0...geo.size.height)
                        )
                }
            }
            .ignoresSafeArea()
            .onAppear { ySeed = .random(in: 0...geo.size.height) }
        }
    }
}
