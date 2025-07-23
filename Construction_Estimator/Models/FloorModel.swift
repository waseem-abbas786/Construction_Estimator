
import Foundation
struct FloorModel {
    var id = UUID()
    var length : Double
    var width : Double
    
    var area: Double  {
        length * width
    }
    var cementBags : Double {
        area * 0.03
    }
    var sand : Double {
        area * 0.2
    }
    var stone: Double {
        area * 0.3
    }
    func estmatedCost (cementPrice: Double, sandPriceper200Sq: Double,stonePrice: Double) -> Double {
        let sandCost = (sand / 200) * sandPriceper200Sq
        return (cementBags * cementPrice) + sandCost + (stone * stonePrice)
    }
}
