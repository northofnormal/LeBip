//
//  AppColors.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

enum AppColor: Equatable {
    // app standard colors
    static let bgPrimary = Color(hex: "#0F172A")
    static let bgAlt = Color(hex: "#1E293B")
    static let textPrimary = Color(hex: "#F8FAFC")
    static let textSecondary = Color(hex: "#CBD5E1")

    // player colors
    static let playerBlue = Color(hex: "#3B82F6")
    static let playerCoral = Color(hex: "#F97316")
    static let playerMustard = Color(hex: "#EAB308")
    static let playerTeal = Color(hex: "#14B8A6")
    static let playerGrape = Color(hex: "#8B5CF6")
    static let playerRose = Color(hex: "#F43F5E")

    static let playerColors: [Color] = [
        playerBlue,
        playerCoral,
        playerMustard,
        playerTeal,
        playerGrape,
        playerRose
    ]
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        let opacity = Double((rgb >> 24) & 0xFF) / 255.0 // Handles hex strings with alpha

        self.init(red: red, green: green, blue: blue, opacity: opacity == 0 ? 1 : opacity)
    }
}

