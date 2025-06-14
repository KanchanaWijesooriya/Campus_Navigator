//
//  MapView.swift
//  CampusNavigator
//
//  Created by Geeneth 013 on 2025-06-08.
//
//import SwiftUI
//
//struct MapView: View {
//    @State private var showFloorSelector = false
//    @State private var selectedFloor = "None"
//
//    var body: some View {
//        ZStack {
//            // Background placeholder image
//            Image(systemName: "globe.americas.fill")
//                .resizable()
//                .scaledToFit()
//                .foregroundColor(.blue.opacity(0.3))
//                .frame(width: 200, height: 200)
//                .background(Color.gray.opacity(0.1))
//                .clipShape(Circle())
//                .padding()
//
//            VStack {
//                // Page title
//                Text("Map")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.top, 50)
//
//                // Show currently selected floor (optional)
//                if selectedFloor != "None" {
//                    Text("Selected Floor: \(selectedFloor)")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        .padding(.top, 10)
//                }
//
//                Spacer()
//
//                // Select Floor Button
//                Button(action: {
//                    showFloorSelector = true
//                }) {
//                    Text("Floor Select")
//                        .fontWeight(.semibold)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .padding(.horizontal)
//                }
//                .padding(.bottom, 100)
//                .confirmationDialog("Select a Floor", isPresented: $showFloorSelector, titleVisibility: .visible) {
//                    Button("Ground") { selectedFloor = "Ground" }
//                    Button("First Floor") { selectedFloor = "First Floor" }
//                    Button("Second Floor") { selectedFloor = "Second Floor" }
//                    Button("Cancel", role: .cancel) {}
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
//
//

import SwiftUI

struct MapView: View {
    @State private var showFloorSelector = false
    @State private var selectedFloor = "None"

    var body: some View {
        ZStack {
            VStack {
                // Page title
                Text("Map")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                // Show currently selected floor
                if selectedFloor != "None" {
                    Text("Selected Floor: \(selectedFloor)")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }

                Spacer()

                // Display appropriate image based on selection
                if selectedFloor == "Ground" {
                    Image("GroundMap")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 600)
                        .padding()
                } else {
                    Image(systemName: "globe.americas.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.blue.opacity(0.3))
                        .frame(width: 200, height: 200)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                        .padding()
                }

                Spacer()

                // Floor selection button
                Button(action: {
                    showFloorSelector = true
                }) {
                    Text("Floor Select")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.bottom, 90)
                .confirmationDialog("Select a Floor", isPresented: $showFloorSelector, titleVisibility: .visible) {
                    Button("Ground") { selectedFloor = "Ground" }
                    Button("First Floor") { selectedFloor = "First Floor" }
                    Button("Second Floor") { selectedFloor = "Second Floor" }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
