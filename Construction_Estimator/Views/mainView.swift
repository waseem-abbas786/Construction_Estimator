import SwiftUI

struct MainView: View {
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

                VStack(spacing: 16) {
                    if isAnimate {
                        NavigationLink {
                            RoomEstimatorView(viewModel: roomVM)
                        } label: {
                            estimatorButton(icon: "house.fill", text: "Estimate Room Cost", color: .blue)
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))

                        NavigationLink {
                            RoofEstimatorView(viewModel: roofVM)
                        } label: {
                            estimatorButton(icon: "triangle.fill", text: "Estimate Roof Cost", color: .orange)
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))

                        NavigationLink {
                            FloorEstimatorView(viewModel: floorVM)
                        } label: {
                            estimatorButton(icon: "square.grid.3x3.fill", text: "Estimate Floor Cost", color: .green)
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                }
                .tint(.primary)
                .animation(.easeOut(duration: 0.5), value: isAnimate)

                Divider()
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
                            Button {
                                withAnimation {
                                    roomVM.resetRooms()
                                    roofVM.reset()
                                    floorVM.reset()
                                }
                            } label: {
                                Text("Reset All")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red.opacity(0.15))
                                    .foregroundColor(.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .padding(.top, 8)
                        }
                        .transition(.scale.combined(with: .opacity))
                        .padding(.horizontal)
                    }

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
    
    @ViewBuilder
    private func estimatorButton(icon: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
            Text(text)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MainView()
}
