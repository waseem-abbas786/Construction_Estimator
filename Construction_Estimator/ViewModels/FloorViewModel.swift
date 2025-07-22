
import Foundation
class FloorViewModel: ObservableObject {
  @Published var currentFloor = FloorModel(length: 0, width: 0)
    @Published var floors : [FloorModel] = []
    @Published var cementPrice : Double = 0
    @Published var sandPricePer200Sq : Double = 0
    @Published var stonePriceperSq : Double = 0
    
    func addCurrentFloor () {
        floors.append(currentFloor)
        currentFloor = FloorModel(length: 0, width: 0)
    }
    var totalCementBags : Double {
        floors.reduce(0) {$0 + $1.cementBags}
    }
    var totalSand : Double {
        floors.reduce(0) {$0 + $1.sand}
    }
    var totalStone  : Double {
        floors.reduce(0) {$0 + $1.stone}
    }
    var totalCost : Double {
        floors.reduce(0) {
            $0 + $1.cost(cementPrice: cementPrice, sandPriceper200Sq: sandPricePer200Sq, stonePrice: stonePriceperSq)
        }
    }
}

