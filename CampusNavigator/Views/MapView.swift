//
//  MapView.swift
//  CampusNavigator
//
//  Created by Geeneth 013 on 2025-06-08.
//

import SwiftUI

struct MapView: View {
    @State private var showFloorSelector = false
    @State private var selectedFloor = "Ground"
    @State private var showPopup = false
    @State private var tapLocation: CGPoint = .zero
    @State private var searchText: String = ""

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Centered Title
                HStack {
                    Spacer()
                    Text("Map")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 90)
                    Spacer()
                }

                // Search Bar
                TextField("Search for a room...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 8)

                // Selected Floor Label
                Text("Selected Floor: \(selectedFloor)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top, 4)

                Spacer()

                // Map Image Based on Floor (Centered)
                Group {
                    if selectedFloor == "Ground" {
                        CenteredMapImage(named: "GroundMap")
                    } else if selectedFloor == "First Floor" {
                        CenteredMapImage(named: "FirstFloor")
                    } else if selectedFloor == "Second Floor" {
                        CenteredMapImage(named: "SecondFloor")
                    } else {
                        CenteredPlaceholder()
                    }
                }
                .coordinateSpace(name: "mapView")
                .onTapGesture(coordinateSpace: .named("mapView")) { location in
                    tapLocation = location
                    showPopup = true
                }

                Spacer()

                // Floor Selector Button
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
                .padding(.bottom, 110)
                .confirmationDialog("Select a Floor", isPresented: $showFloorSelector, titleVisibility: .visible) {
                    Button("Ground") { selectedFloor = "Ground" }
                    Button("First Floor") { selectedFloor = "First Floor" }
                    Button("Second Floor") { selectedFloor = "Second Floor" }
                    Button("Cancel", role: .cancel) {}
                }
            }

            // Popup View
            if showPopup {
                Text("Lecture Hall 3")
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .position(tapLocation)
                    .onTapGesture {
                        showPopup = false
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct CenteredMapImage: View {
    let named: String

    var body: some View {
        HStack {
            Spacer()
            Image(named)
                .resizable()
                .scaledToFit()
                .frame(height: 550)
                .padding()
                .contentShape(Rectangle())
            Spacer()
        }
    }
}

struct CenteredPlaceholder: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "globe.americas.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue.opacity(0.3))
                .frame(width: 200, height: 200)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
                .padding()
                .contentShape(Rectangle())
            Spacer()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


