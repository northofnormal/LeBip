//
//  View+Extensions.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/24/26.
//

import SwiftUI

extension View {
    func displayConfetti(isActive: Binding<Bool>) -> some View {
        modifier(DisplayConfettiModifier(isActive: isActive))
    }
}
