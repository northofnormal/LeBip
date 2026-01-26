//
//  EmptyPlayersView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

struct EmptyPlayersView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.badge.plus")
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .foregroundStyle(AppColor.playerTeal )

            Text("No players yet")
                .textStyle(BodyTextStyle())
        }
        .padding(20)
        .background(AppColor.bgAlt)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 3)
        )
    }
}

#Preview {
    EmptyPlayersView()
}
