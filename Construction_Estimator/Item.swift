//
//  Item.swift
//  Construction_Estimator
//
//  Created by Waseem Abbas on 21/07/2025.
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
