
import Foundation
class RoofViewModel : ObservableObject {
    @Published var roof = Roof(length: 0, width: 0)
    @Published var cementPrice : Double = 0
    @Published var sandPricePertwoHundredSq : Double = 0
    @Published var stonePrice : Double = 0
    @Published var steelPrice : Double = 0
    @Published var laborRatePerSqFt : Double = 0
    var area : Double {
        roof.length * roof.width
    }
    var steel : Double {
        area * 1.0
    }
    var cementBags : Double {
        area / 14.4
    }
    var sand : Double {
        cementBags * 3
    }
    var stone : Double {
        cementBags * 6
    }
    var totalCost : Double {
        let sandCost = Double(sand / 200) * sandPricePertwoHundredSq
        return   (cementBags * cementPrice) + (sand * sandCost) + (stone * stonePrice) + (steel * steelPrice) + (area * laborRatePerSqFt)
    }
}
