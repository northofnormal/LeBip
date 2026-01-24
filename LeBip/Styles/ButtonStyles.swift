//
//  ButtonStyles.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/23/26.
//

import SwiftUI

struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration)  -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColor.playerBlue)
            .clipShape(Capsule())
    }
}

struct LargeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColor.playerRose)
            .cornerRadius(15)
    }
}
