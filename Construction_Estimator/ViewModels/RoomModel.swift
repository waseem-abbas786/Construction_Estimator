//
//  RoomModel.swift
//  Construction_Estimator
//
//  Created by Waseem Abbas on 21/07/2025.
//

import Foundation
enum WallType : String, CaseIterable, Identifiable {
    case fourInch = "4 Inch"
    case nineInch = "9 Inch"
    case thirteenInch = "13 inch"
    var id : String{ self.rawValue}
    var bricksPer100sqft : Int {
        switch self {
        case .fourInch: return 450
        case .thirteenInch:
            return 950
        case .nineInch:
            return 1300
        }
    }
    
}
struct Room {
    var lenght : Double
    var width : Double
    var height : Double
    var wallType : WallType
}
