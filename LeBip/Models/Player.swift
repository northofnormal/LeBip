//
//  Player.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import Foundation
import SwiftUI

struct Player: Identifiable, Equatable, Hashable {
    let id: UUID
    var name: String
    var color: Color
}

extension Player {
    static var emptyPlayer: Self {
        Player(id: UUID(), name: "", color: .clear)
    }
}
