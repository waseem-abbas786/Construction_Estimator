

import Foundation
enum RoofType :String,CaseIterable,Identifiable {
    case rcc = "RCC"
    case rbb = "RBB"
    var id : String {self.rawValue}
    var steelPerSqFt: Double {
        switch self {
        case .rcc: return 2.0
        case .rbb: return 1.0
        }
    }
        var bricksPerSqFt: Double {
            switch self {
            case .rcc: return 0
            case .rbb: return 2.0
            }
        }
    }

struct Roof {
    var id = UUID()
    var length : Double
    var width : Double
    var roofType : RoofType
    var area : Double {
        length * width
    }
}
