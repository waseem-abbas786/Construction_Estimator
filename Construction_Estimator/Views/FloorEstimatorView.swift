//
//  FloorEstimatorView.swift
//  Construction_Estimator
//
//  Created by Waseem Abbas on 22/07/2025.
//

import SwiftUI

struct FloorEstimatorView: View {
    @StateObject var viewModel = FloorViewModel()
    @State  var showSummary : Bool = false
    var body: some View {
        Form {
            Section (header: Text ("Floor_Dimension")) {
                HStack {
                    Text ("Length :")
                    TextField("Floor_length", value: $viewModel.currentFloor.length, format: .number)
                        .inputStyle
                }
                HStack {
                    Text("Width :")
                    TextField("Floor_Width", value: $viewModel.currentFloor.width, format: .number)
                        .inputStyle
                }
            }
            .bold()
            .font(.headline)
            Section (header: Text ("Materia_price")) {
                HStack {
                    Text ("Cement_price")
                    TextField("Cement_Price", value: $viewModel.cementPrice, format: .number)
                        .inputStyle
                }
                HStack{
                    Text("Sand_price")
                    TextField("Sand_Price", value: $viewModel.sandPricePer200Sq, format: .number)
                        .inputStyle
                }
                HStack {
                    Text("Stone_Price")
                    TextField("Stone_Price", value: $viewModel.stonePriceperSq, format: .number)
                        .inputStyle
                }
            }
            .bold()
            .font(.headline)
            Section {
                Button("Add") {
                    viewModel.addCurrentFloor()
                }
                .disabled(!viewModel.isFloorIsValid)
                .buttonStyle
                Button("Done") {
                   showSummary = true
                }
                .buttonStyle
            }
            if !viewModel.floors.isEmpty {
                Section( header: Text("Saved_Floor_Summaery")) {
                    ForEach (Array(viewModel.floors.enumerated()), id: \.offset) { index, floor in
                        let cost = floor.estmatedCost(cementPrice: viewModel.cementPrice, sandPriceper200Sq: viewModel.sandPricePer200Sq, stonePrice: viewModel.stonePriceperSq
                        )
                        VStack (alignment: .leading) {
                            Text("Floor \(index + 1) : \(floor.length) x \(floor.width)")
                            Text("Estimated_Cost: Rs \(cost, specifier: "%.2f")")
                        }
                        .padding(.vertical, 5)
                        
                    }
                    Text("Grand_Total: Rs \(viewModel.totalCost, specifier: "%.2f")")
                        .bold()
                        .padding(.top)
                }
            }
        }
        .navigationTitle("Floor_Estimation")
        .sheet(isPresented: $showSummary) {
            FloorSummaryView(viewModel: viewModel)
        }
    }
}

#Preview {
    NavigationView {
        FloorEstimatorView()
    }
  
}

struct FloorSummaryView: View {
    @ObservedObject var viewModel: FloorViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Floor Summary")
                .font(.title)
                .bold()

            Text("Total Cement Bags: \(viewModel.totalCementBags, specifier: "%.2f")")
            Text("Total Sand (sq ft): \(viewModel.totalSand, specifier: "%.2f")")
            Text("Total Stone (sq ft): \(viewModel.totalStone, specifier: "%.2f")")
            Text("Grand Total Cost: Rs. \(viewModel.totalCost, specifier: "%.2f")")
                .font(.title2)
                .foregroundColor(.green)
        }
        .padding()
    }
}

