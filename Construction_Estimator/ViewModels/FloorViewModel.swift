
import Foundation
class FloorViewModel: ObservableObject {
   @Published var floor = FloorModel(length: 0, width: 0)
    @Published var cementPrice : Double = 0
    @Published var sandPricepertwoHundredsq : Double = 0
    @Published var stonePriceperSq : Double = 0
    
    var area : Double {
        floor.length * floor.width
    }
    var cementBags : Double {
        area / 28
    }
    var sand : Double {
        cementBags * 12
    }
    var stone : Double {
        cementBags * 12
    }
    var totalCost : Double {
        let sandCost = Double(sand / 200) * sandPricepertwoHundredsq
        return (cementBags * cementPrice) + (sand * sandCost) + (stone * stonePriceperSq)
    }
    }

