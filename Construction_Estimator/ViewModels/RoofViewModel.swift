import Foundation

class RoofViewModel : ObservableObject {
    @Published var currentRoof = Roof(length: 0, width: 0, roofType: .rbb)
    @Published var roofs : [Roof] = []
    
    @Published var cementPrice : Double = 0
    @Published var sandPricePer200SqFt : Double = 0
    @Published var stonePrice : Double = 0
    @Published var steelPrice : Double = 0
    @Published var laborRatePerSqFt : Double = 0
    @Published var brickPricePerThousand: Double = 0
  
    func addCurrentRoof () {
        roofs.append(currentRoof)
        currentRoof = Roof(length: 0, width: 0, roofType: .rcc)
    }
    
    func estimateCost(for roof : Roof) -> Double {
        let area = roof.area
        let cementBags = area * 0.05
        let sand = area * 0.1
        let stone = area * 0.4
        let steel = area * roof.roofType.steelPerSqFt
        let bricks = area * roof.roofType.bricksPerSqFt
        
        let cementCost = cementBags * cementPrice
        let sandCost = (sand / 200) * sandPricePer200SqFt
        let stoneCost = stone * stonePrice
        let steelCost = steel * steelPrice
        let brickCost = (bricks / 1000) * brickPricePerThousand
        let laborCost = area * laborRatePerSqFt
        return cementCost + sandCost + steelCost + stoneCost + laborCost + brickCost
    }
    
    var totalCost: Double {
        roofs.reduce(0) { $0 + estimateCost(for: $1) }
    }
    var totalCementBags : Double {
        roofs.reduce(0) { $0 + ($1.area / 14.4) }
    }
    var totalSand : Double {
        roofs.reduce(0) { $0 + ($1.area / 14.4) * 3 }
    }
    var totalSteel : Double {
        roofs.reduce(0) { $0 + $1.area * $1.roofType.steelPerSqFt }
    }
    var totalBricks : Double {
        roofs.reduce(0) { $0 + $1.area * $1.roofType.bricksPerSqFt }
    }
    var totalStone : Double {
        roofs.reduce(0) { $0 + ($1.area / 14.4) * 6 }
    }
    var totalLabourCost : Double {
        roofs.reduce(0) { $0 + $1.area * laborRatePerSqFt }
    }
    
    // ✅ Reset everything
    func reset() {
        roofs.removeAll()
        currentRoof = Roof(length: 0, width: 0, roofType: .rbb)
        cementPrice = 0
        sandPricePer200SqFt = 0
        stonePrice = 0
        steelPrice = 0
        laborRatePerSqFt = 0
        brickPricePerThousand = 0
    }
}
