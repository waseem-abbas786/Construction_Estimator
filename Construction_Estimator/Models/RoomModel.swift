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
    var id = UUID()
    var lenght : Double
    var width : Double
    var height : Double
    var wallType : WallType
    func wallArea () -> Double {
        2 * (lenght + width) * height
    }
    func estimateCost(bricksPerThousand : Double, cementPrice: Double, sandPricePer200Sq : Double) -> Double {
        let area = wallArea()
        let bricks = (area / 100) * Double(wallType.bricksPer100sqft)
        let cementWall = (area / 100) * 1.25
        let cementPlaster = (area / 100) * 3
        let sand = area * 0.37
        
        let brickCost = (bricks / 1000) * bricksPerThousand
        let cementCost = (cementWall + cementPlaster) * cementPrice
        let sandCost = (sand / 200) * sandPricePer200Sq
        return brickCost + cementCost + sandCost
    }
}
