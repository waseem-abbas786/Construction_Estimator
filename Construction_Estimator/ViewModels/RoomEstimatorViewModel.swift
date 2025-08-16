import Foundation

class RoomEstimatorViewModel : ObservableObject {
    @Published var rooms: [Room] = []
    @Published var currentRoom = Room(lenght: 0, width: 0, height: 0, wallType: .nineInch)
    
    @Published var bricksPricePerThousand : Double = 0
    @Published var cementPrice : Double = 0
    @Published var sandPricePer200Sq : Double = 0
    
    func addCurrentRoom() {
        rooms.append(currentRoom)
        currentRoom = Room(lenght: 0, width: 0, height: 0, wallType: .nineInch)
    }
    
    func resetRooms() {
        rooms.removeAll()
        currentRoom = Room(lenght: 0, width: 0, height: 0, wallType: .nineInch)
        bricksPricePerThousand = 0
        cementPrice = 0
        sandPricePer200Sq = 0
    }
    
    var totalCost : Double {
        rooms.reduce(0) { partialResult, room in
            partialResult + room.estimateCost(
                bricksPerThousand: bricksPricePerThousand,
                cementPrice: cementPrice,
                sandPricePer200Sq: sandPricePer200Sq
            )
        }
    }
    
    var totalWallArea : Double {
        rooms.reduce(0) { $0 + $1.wallArea() }
    }
    
    var totalBricks : Int {
        rooms.reduce(0) { $0 + Int(($1.wallArea() / 100) * Double($1.wallType.bricksPer100sqft)) }
    }
    
    var totalCementBags : Double {
        rooms.reduce(0) { result, room in
            let area = room.wallArea()
            return result + ((area / 100) * (1.25 + 3))
        }
    }
    
    var totalSand : Double {
        rooms.reduce(0) { $0 + ($1.wallArea() * 0.37) }
    }
    
    var isCurrentRoomValid: Bool {
        currentRoom.lenght > 0 &&
        currentRoom.width > 0 &&
        currentRoom.height > 0 &&
        bricksPricePerThousand > 0 &&
        cementPrice > 0 &&
        sandPricePer200Sq > 0
    }
}
