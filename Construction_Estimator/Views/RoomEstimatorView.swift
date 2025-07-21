//
//  RoomEstimatorView.swift
//  Construction_Estimator
//
//  Created by Waseem Abbas on 21/07/2025.
//

import SwiftUI

struct RoomEstimatorView: View {
    @StateObject var ViewModel = RoomEstimatorViewModel()
    var body: some View {
        Form {
            RoomView(viewModel: ViewModel)
            MaterialPriceView(viewModel: ViewModel)
            EstimationView(viewModel: ViewModel)
            Section(header: Text("Total Cost")) {
                Text("The Estimated Cost: Rs. \(ViewModel.totalCost, specifier: "%.2f")")
                    .fontWeight(.bold)
            }
        }
        .navigationTitle("Room Estimator")
    }
}

#Preview {
    RoomEstimatorView()
}
extension View {
    var inputStyle : some View {
        self
            .padding()
            .frame(height: 35 )
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
    }
}
// MARK: Room-DimensionView
struct RoomView : View {
    @ObservedObject var viewModel: RoomEstimatorViewModel
    var body: some View {
        Section(header: Text("Room Dimentions")
        ) {
            HStack {
                Text("Room_Length :")
                TextField("Length", value: $viewModel.room.lenght, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Room_Width :")
                TextField("Width", value: $viewModel.room.width, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Room_Height :")
                TextField("Height", value: $viewModel.room.height, format: .number)
                    .inputStyle
            }
            Picker("Wall Type", selection: $viewModel.room.wallType) {
                ForEach(WallType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
        }
        .bold()
        .font(.headline)
    }
}
//MARK: Material_Prices
struct MaterialPriceView : View {
    @ObservedObject var viewModel : RoomEstimatorViewModel
    var body: some View {
        Section (header: Text("Material Prices Per Unit")) {
            HStack {
                Text("Bricks_Price")
                TextField("Brick Price", value: $viewModel.bricksPricePerThousand, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Cement_Price : ")
                TextField("Cement Price", value: $viewModel.cementPrice, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Sand_Price")
                TextField("Sand Price", value: $viewModel.sandPricePertwoHundredSq, format: .number)
                    .inputStyle
            }
            
            
        }
        .bold()
        .font(.headline)
    }
}
//MARK: EstimationView
struct EstimationView : View {
    @ObservedObject var viewModel : RoomEstimatorViewModel
    var body: some View {
        Section(header: Text("Estimates")) {
            Text("Wall Area: \(viewModel.wallAerea, specifier: "%.2f")sq ft ")
            Text("Bricks : \(viewModel.bricksCount)")
            Text("Cement Bags (Wall): \(viewModel.cementBagsWall, specifier: "%.2f")")
            Text("Cement Bags (Plaster): \(viewModel.plasterCementBags, specifier: "%.2f")")
            Text("sand: \(viewModel.sand, specifier: "%.2f") sq ft")
        }
        .font(.headline)
    }
}
