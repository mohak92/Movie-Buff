//
//  Item.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/17/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
