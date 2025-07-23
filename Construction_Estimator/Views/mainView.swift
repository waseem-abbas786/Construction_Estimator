import SwiftUI

struct mainView: View {
    @StateObject var roomVM = RoomEstimatorViewModel()
    @StateObject var roofVM = RoofViewModel()
    @StateObject var floorVM = FloorViewModel()
    @State private var isAnimate: Bool = false

    var totalGrandCost: Double {
        roomVM.totalCost + roofVM.totalCost + floorVM.totalCost
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("🏗️ Construction Estimator")
                    .font(.title)
                    .bold()
                    .padding(.top, 40)

                Text("Quickly estimate building costs for rooms, roofs, and floors. Enter dimensions and material prices to get accurate totals for cement, sand, bricks, and more.")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .padding(.horizontal)

                Divider()

                VStack(spacing: 12) {
                    if isAnimate {
                        NavigationLink {
                            RoomEstimatorView(viewModel: roomVM)
                        } label: {
                            HStack {
                                Image(systemName: "house")
                                Text("Estimate Room Cost")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        }

                        NavigationLink {
                            RoofEstimatorView(viewModel: roofVM)
                        } label: {
                            HStack {
                                Image(systemName: "roof")
                                Text("Estimate Roof Cost")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        }

                        NavigationLink {
                            FloorEstimatorView(viewModel: floorVM)
                        } label: {
                            HStack {
                                Image(systemName: "square.grid.3x3.fill")
                                Text("Estimate Floor Cost")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                    }
                }
                .tint(.primary)
                .animation(.easeOut(duration: 0.4), value: isAnimate)

                Divider()

                Group {
                    if totalGrandCost == 0 {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 100)
                            .overlay(
                                Text("Start by entering your room, roof, or floor details above to get a full cost estimate.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            )
                            .padding(.horizontal)
                            .transition(.opacity)
                    } else {
                        VStack(spacing: 10) {
                            Text("Total Estimated Cost")
                                .font(.title3)
                            Text("Rs. \(totalGrandCost, specifier: "%.2f")")
                                .font(.title)
                                .foregroundColor(.green)
                                .bold()
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.easeInOut, value: totalGrandCost)

                Spacer()
            }
            .padding()
            .navigationTitle("Estimator Menu")
            .onAppear {
                withAnimation {
                    isAnimate = true
                }
            }
        }
    }
}

#Preview {
    mainView()
}
