//
//  mainView.swift
//  Construction_Estimator
//
//  Created by Waseem Abbas on 21/07/2025.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("🏗️ Construction Estimator")
                    .font(.title)
                    .bold()
                    .padding(.top, 40)
                Divider()
                VStack (spacing: 10) {
                    NavigationLink {
                        RoomEstimatorView()
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "house")
                            Text(" Estimate the cost of Rooms")
                        }
                       
                    }
                    NavigationLink {
                        RoofEstimatorView()
                    } label: {
                        HStack(spacing: 0){
                            Image(systemName: "door.right.hand.closed")
                            Text(" Estimate the cost of Roofs")
                        }
                        
                    }
                    NavigationLink {
                        FloorEstimatorView()
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "lightbulb.min")
                            Text(" Estimate the cost of Floor")
                        }
                        
                    }

                }
                .tint(Color.primary)
                .frame(maxWidth:.infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(.buttonBorder)


                Spacer()
            }
            .padding()
            .navigationTitle("Estimator Menu")
        }
    }

}


#Preview {
    NavigationView {
        mainView()
    }
    
}
