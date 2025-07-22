
import Foundation
struct FloorModel {
    var id = UUID()
    var length : Double
    var width : Double
    var area: Double  {
        length * width
    }
    var cementBags : Double {
        area / 28
    }
    var sand : Double {
        cementBags * 6
    }
    var stone: Double {
        cementBags * 12
    }
    func cost (cementPrice: Double, sandPriceper200Sq: Double,stonePrice: Double) -> Double {
        let sandCost = (sand / 200) * sandPriceper200Sq
        return (cementBags * cementPrice) + sandCost + (stone * stonePrice)
    }
}
