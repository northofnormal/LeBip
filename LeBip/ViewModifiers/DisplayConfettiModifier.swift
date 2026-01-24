//
//  DisplayConfettiModifier.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/24/26.
//

import SwiftUI

struct DisplayConfettiModifier: ViewModifier {
    @Binding var isActive: Bool {
        didSet { if !isActive { opacity = 1 } }
    }
    @State private var opacity = 1.0 {
        didSet { if opacity == 0 { isActive = false } }
    }

    private let animationTime = 3.0       // full timing controls in source link
    private let fadeTime = 1.6

    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content
                .overlay(isActive ? ConfettiContainerView().opacity(opacity) : nil)
                .sensoryFeedback(.success, trigger: isActive)   // optional on older iOS
                .task { await sequence() }
        } else {
            content
                .overlay(isActive ? ConfettiContainerView().opacity(opacity) : nil)
                .task { await sequence() }
        }
    }

    private func sequence() async {
        do {
            try await Task.sleep(nanoseconds: UInt64(animationTime * 1_000_000_000))
            withAnimation(.easeOut(duration: fadeTime)) { opacity = 0 }
        } catch {}
    }
}
