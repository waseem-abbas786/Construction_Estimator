//
//  RoomEstimatorView.swift
//  Construction_Estimator
//
//  Created by Waseem Abbas on 21/07/2025.
//

import SwiftUI

struct RoomEstimatorView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = RoomEstimatorViewModel()
    @State var showSummary : Bool = false
    var body: some View {
        
        return Form {
            RoomView(viewModel: viewModel)
            MaterialPriceView(viewModel: viewModel)

            Section {
                    Button("Add Room") {
                        viewModel.addCurrentRoom()
                    }
                    .disabled(!viewModel.isCurrentRoomValid)
                    .buttonStyle
                  
                    Button("Done") {
                        showSummary = true
                   
                    }
                    .buttonStyle
                
             
                
                
            }
            if !viewModel.rooms.isEmpty {
                Section(header: Text("Saved Rooms Summary")) {
                    ForEach(Array(viewModel.rooms.enumerated()), id: \.offset) { index, room in
                        let cost = room.estimateCost(
                            bricksPerThousand: viewModel.bricksPricePerThousand,
                            cementPrice: viewModel.cementPrice,
                            sandPricePer200Sq: viewModel.sandPricePer200Sq
                        )

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Room \(index + 1): \(room.lenght) x \(room.width) x \(room.height)")
                                .font(.headline)
                            Text("Wall Type: \(room.wallType.rawValue)")
                            Text("Estimated Cost: Rs. \(cost, specifier: "%.2f")")
                        }
                        .padding(.vertical, 5)
                    }

                    Text("Grand Total: Rs. \(viewModel.totalCost, specifier: "%.2f")")
                        .bold()
                        .padding(.top)
                }
            }
        }
        .navigationTitle("Room Estimator")
        .sheet(isPresented: $showSummary) {
            SummaryView(viewModel: viewModel)
           
        }
        
    }



}

#Preview {
    NavigationView {
        RoomEstimatorView()
    }
}
//MARK: Style components
extension View {
    var inputStyle : some View {
        self
            .padding()
            .frame(height: 35 )
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
    }
}
extension View {
    var buttonStyle : some View {
        self
            .foregroundStyle(Color.white)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.8))
            .clipShape(.buttonBorder)
        
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
                TextField("Length", value: $viewModel.currentRoom.lenght, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Room_Width :")
                TextField("Width", value: $viewModel.currentRoom.width, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Room_Height :")
                TextField("Height", value: $viewModel.currentRoom.height, format: .number)
                    .inputStyle
            }
            Picker("Wall Type", selection: $viewModel.currentRoom.wallType) {
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
        Section(header: Text("Material Prices Per Unit")) {
            HStack{
                Text("Brick_Price")
                TextField("Bricks Price/1000", value: $viewModel.bricksPricePerThousand, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Cement_Price")
                TextField("Cement Bag Price", value: $viewModel.cementPrice, format: .number)
                    .inputStyle
            }
                      
            HStack {
                Text("Sand_cost")
                TextField("Sand Price (200 sq ft)", value: $viewModel.sandPricePer200Sq, format: .number)
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
        Section(header: Text("Current Room Estimation")) {
                          let area = viewModel.currentRoom.wallArea()
                          let bricks = (area / 100) * Double(viewModel.currentRoom.wallType.bricksPer100sqft)
            let cementWall = (area / 100) * 1.25
                          let cementPlaster = (area / 100) * 3
            let sand = area * 0.37
                          let cost = viewModel.currentRoom.estimateCost(
                            bricksPerThousand: viewModel.bricksPricePerThousand,
                              cementPrice: viewModel.cementPrice,
                              sandPricePer200Sq: viewModel.sandPricePer200Sq
                          )
                          
                          Text("Wall Area: \(area, specifier: "%.2f") sq ft")
                          Text("Bricks: \(Int(bricks))")
                          Text("Cement Bags (Wall): \(cementWall, specifier: "%.2f")")
                          Text("Cement Bags (Plaster): \(cementPlaster, specifier: "%.2f")")
                          Text("Sand: \(sand, specifier: "%.2f") sq ft")
                          Text("Estimated Room Cost: Rs. \(cost, specifier: "%.2f")")
                              .bold()
                      }
        .font(.headline)
    }
}
//MARK: Summaery Sheet Model
struct SummaryView: View {
    @ObservedObject var viewModel: RoomEstimatorViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Project Summary")
                .font(.title)
                .bold()

            
                Text("Total Wall Area: \(viewModel.totalWallArea, specifier: "%.2f") sq ft")
            Text("Total Bricks: \(viewModel.totalBricks)")
                Text("Total Cement Bags: \(viewModel.totalCementBags, specifier: "%.2f")")
                Text("Total Sand: \(viewModel.totalSand, specifier: "%.2f") sq ft")
            
            .font(.headline)

            Divider()

            Text("Grand Total Cost")
                .font(.title2)
                .foregroundColor(.green)

            Text("Rs. \(viewModel.totalCost, specifier: "%.2f")")
                .bold()
                .font(.title)
        }
        .padding()
    }
}
