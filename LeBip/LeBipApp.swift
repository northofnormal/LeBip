//
//  LeBipApp.swift
//  LeBip
//
//  Created by Anne Cahalan on 8/29/25.
//

import SwiftUI

@main
struct LeBipApp: App {
    @AppStorage("playerColorIndex") var playerColorIndex = 0

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(
                    \.playerColor,
                     .playerColors[playerColorIndex]
                )
        }
    }
}
