import SwiftUI

struct RoofEstimatorView: View {
    @StateObject var viewModel = RoofViewModel()
    @State var showSummary: Bool = false

    var body: some View {
        Form {
            RoofDimentionView(viewModel: viewModel)

            Section(header: Text("Material Prices")) {
                HStack {
                    Text("Cement Price:")
                    TextField("Cement Price", value: $viewModel.cementPrice, format: .number)
                        .inputStyle
                }
                HStack {
                    Text("Sand Price:")
                    TextField("Sand Price (200 sq ft)", value: $viewModel.sandPricePer200SqFt, format: .number)
                        .inputStyle
                }
                HStack {
                    Text("Stone Price:")
                    TextField("Stone Price", value: $viewModel.stonePrice, format: .number)
                        .inputStyle
                }
                HStack {
                    Text("Steel Price:")
                    TextField("Steel Price", value: $viewModel.steelPrice, format: .number)
                        .inputStyle
                }
                HStack {
                    Text("Labour_Cost:")
                    TextField("Labour_cost", value: $viewModel.laborRatePerSqFt, format: .number)
                        .inputStyle
                }
                if viewModel.currentRoof.roofType == .rbb {
                    HStack {
                        Text("Brick Price:")
                        TextField("Brick Price (per 1000)", value: $viewModel.brickPricePerThousand, format: .number)
                            .inputStyle
                    }
                }
            }

            Section {
                Button("Add Roof") {
                    viewModel.addCurrentRoof()
                }
                .buttonStyle

                Button("Done") {
                    showSummary = true
                }
                .buttonStyle
            }

            if !viewModel.roofs.isEmpty {
                Section(header: Text("Saved Roofs Summary")) {
                    ForEach(Array(viewModel.roofs.enumerated()), id: \.offset) { index, roof in
                        let cost = viewModel.estimateCost(for: roof)
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Roof \(index + 1): \(roof.length) x \(roof.width)")
                                .font(.headline)
                            Text("Type: \(roof.roofType.rawValue)")
                            Text("Estimated Cost: Rs. \(cost, specifier: "%.2f")")
                        }
                        .padding(.vertical, 4)
                    }
                    Text("Grand Total: Rs. \(viewModel.totalCost, specifier: "%.2f")")
                        .bold()
                        .padding(.top)
                }
            }
        }
        .sheet(isPresented: $showSummary) {
            RoofSummaryView(viewModel: viewModel)
        }
        .navigationTitle("Roof Estimator")
    }
}
#Preview {
    RoofEstimatorView()
}

struct RoofSummaryView: View {
    @ObservedObject var viewModel: RoofViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Roof Estimation Summary")
                .font(.title2)
                .bold()
            Group {
                Text("Total Cement Bags: \(viewModel.totalCementBags, specifier: "%.2f")")
                Text("Total Sand: \(viewModel.totalSand, specifier: "%.2f") sq ft")
                Text("Total Stone: \(viewModel.totalStone, specifier: "%.2f")")
                Text("Total Steel: \(viewModel.totalSteel, specifier: "%.2f") kg")
                Text("Total Labour Cost : \(viewModel.totalLabourCost, specifier: "%.2f")")
                if viewModel.totalBricks > 0 {
                    Text("Total Bricks: \(Int(viewModel.totalBricks))")
                }
            }
            .font(.headline)

            Divider()
                .padding(.vertical)

            Text("Grand Total Cost")
                .font(.title3)
                .foregroundColor(.green)

            Text("Rs. \(viewModel.totalCost, specifier: "%.2f")")
                .font(.title)
                .bold()
        }
        .padding()
    }
}

//MARK: dimension view
struct RoofDimentionView: View {
    @ObservedObject var viewModel : RoofViewModel
    var body: some View {
        Section(header: Text("Roof Dimensions")) {
            HStack {
                Text("Length:")
                TextField("Roof Length", value: $viewModel.currentRoof.length, format: .number)
                    .inputStyle
            }
            HStack {
                Text("Width:")
                TextField("Roof Width", value: $viewModel.currentRoof.width, format: .number)
                    .inputStyle
            }
            Picker("Roof Type", selection: $viewModel.currentRoof.roofType) {
                ForEach(RoofType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
        }
    }
}
