//
//  RoomEstimatorViewModel.swift
//  Construction_Estimator
//
//  Created by Waseem Abbas on 21/07/2025.
//

import Foundation
class RoomEstimatorViewModel : ObservableObject {
    @Published var room = Room(lenght: 0, width: 0, height: 0, wallType: .nineInch)
    
    @Published var bricksPricePerThousand : Double = 0
    @Published var cementPrice : Double = 0
    @Published var sandPricePertwoHundredSq : Double = 0
    
    var wallAerea : Double {
        2 * ((room.lenght + room.width) * room.height)
    }
    var bricksCount : Int {
        Int((wallAerea / 100) * Double(room.wallType.bricksPer100sqft))
    }
    var cementBagsWall : Double {
        (wallAerea / 100) * 1.25
    }
    var plasterCementBags : Double {
        (wallAerea / 100) * 3
    }
    var sand : Double {
        wallAerea * 0.37
    }
    var totalCost : Double {
        let brickCost = (Double(bricksCount) / 1000) * bricksPricePerThousand
        let wallCementCost = cementBagsWall * cementPrice
        let plasterCementCost = plasterCementBags * cementPrice
        let sandCost = Double(sand / 200) * sandPricePertwoHundredSq
        return brickCost + wallCementCost + plasterCementCost + sandCost
    }
}
