//
//  ConfettiView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/24/26.
//

import SwiftUI

struct ConfettiView: View {
    @State private var animate: Bool = false
    @State private var xSpeed = Double.random(in: 0.7...2.0)
    @State private var zSpeed = Double.random(in: 1.0...2.0)
    @State private var anchor = CGFloat.random(in: 0...1).rounded()

    var body: some View {
        Rectangle()
            .fill(AppColor.playerColors.randomElement() ?? AppColor.playerBlue)
            .frame(width: 14, height: 14)
            .onAppear {
                animate = true
            }
            .rotation3DEffect(.degrees(animate ? 360 : 0), axis: (x: 1, y: 0, z: 0))
            .animation(.linear(duration: xSpeed).repeatForever(autoreverses: false), value: animate)
            .rotation3DEffect(.degrees(animate ? 360 : 0),
                              axis: (x: 0, y: 0, z: 1),
                              anchor: UnitPoint(x: anchor, y: anchor))
            .animation(.linear(duration: zSpeed).repeatForever(autoreverses: false), value: animate)
    }
}
