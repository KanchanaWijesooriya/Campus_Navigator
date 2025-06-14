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
                    .padding(.trailing, 300)
                
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


//import SwiftUI
//
////// Represents a tappable room/section
////struct Room: Identifiable {
////    let id = UUID()
////    let name: String
////    let frame: CGRect // x, y, width, height based on 402x509 image
////}
//
//struct Room: Identifiable, Equatable {
//    let id = UUID()
//    let name: String
//    let frame: CGRect
//
//    static func == (lhs: Room, rhs: Room) -> Bool {
//        lhs.id == rhs.id
//    }
//}
//
//
//struct MapView: View {
//    @State private var showFloorSelector = false
//    @State private var selectedFloor = "None"
//    @State private var selectedRoom: Room? = nil
//
//    // Example interactive rooms for Ground floor map
//    let groundRooms: [Room] = [
//        Room(name: "Lecture Hall A", frame: CGRect(x: 60, y: 30, width: 110, height: 70)),
//        Room(name: "Lecture Hall B", frame: CGRect(x: 230, y: 30, width: 100, height: 70)),
//        Room(name: "Lecture Hall C", frame: CGRect(x: 60, y: 250, width: 100, height: 70)),
//        Room(name: "Lecture Hall D", frame: CGRect(x: 230, y: 250, width: 100, height: 70)),
//    ]
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Text("Map")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.top, 50)
//
//                if selectedFloor != "None" {
//                    Text("Selected Floor: \(selectedFloor)")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        .padding(.top, 10)
//                }
//
//                Spacer()
//
//                if selectedFloor == "Ground" {
//                    ZStack {
//                        GeometryReader { geo in
//                            let imageWidth: CGFloat = 402
//                            let scale = geo.size.width / imageWidth
//
//                            Image("GroundMap")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: geo.size.width)
//                                .clipped()
//
//                            ForEach(groundRooms) { room in
//                                let scaledFrame = CGRect(
//                                    x: room.frame.origin.x * scale,
//                                    y: room.frame.origin.y * scale,
//                                    width: room.frame.width * scale,
//                                    height: room.frame.height * scale
//                                )
//
//                                Rectangle()
//                                    .fill(selectedRoom?.id == room.id ? Color.blue.opacity(0.3) : Color.clear)
//                                    .border(Color.blue, width: selectedRoom?.id == room.id ? 2 : 0)
//                                    .frame(width: scaledFrame.width, height: scaledFrame.height)
//                                    .position(x: scaledFrame.midX, y: scaledFrame.midY)
//                                    .onTapGesture {
//                                        selectedRoom = room
//                                    }
//                            }
//                        }
//                        .frame(height: 600)
//                        .padding()
//                    }
//                } else {
//                    Image(systemName: "globe.americas.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(.blue.opacity(0.3))
//                        .frame(width: 200, height: 200)
//                        .background(Color.gray.opacity(0.1))
//                        .clipShape(Circle())
//                        .padding()
//                }
//
//                Spacer()
//
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
//                .padding(.bottom, 90)
//                .confirmationDialog("Select a Floor", isPresented: $showFloorSelector, titleVisibility: .visible) {
//                    Button("Ground") {
//                        selectedFloor = "Ground"
//                        selectedRoom = nil
//                    }
//                    Button("First Floor") { selectedFloor = "First Floor" }
//                    Button("Second Floor") { selectedFloor = "Second Floor" }
//                    Button("Cancel", role: .cancel) {}
//                }
//            }
//
//            // Bottom popup info for selected room
//            if let room = selectedRoom {
//                VStack {
//                    Spacer()
//
//                    VStack(spacing: 12) {
//                        Text("🧭 Location Selected")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//
//                        Text(room.name)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//
//                        Button(action: {
//                            selectedRoom = nil
//                        }) {
//                            Text("Dismiss")
//                                .font(.subheadline)
//                                .foregroundColor(.blue)
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(16)
//                    .shadow(radius: 8)
//                    .padding(.horizontal)
//                    .padding(.bottom, 250) // <-- moves it above Floor Select button
//                    .transition(.move(edge: .bottom))
//                }
//            }
//
//        }
//        .edgesIgnoringSafeArea(.all)
//        .animation(.easeInOut, value: selectedRoom)
//    }
//}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

//import SwiftUI
//
//// MARK: - Room Struct
//struct Room: Identifiable, Equatable {
//    let id = UUID()
//    let name: String
//    let frame: CGRect
//
//    static func == (lhs: Room, rhs: Room) -> Bool {
//        lhs.id == rhs.id
//    }
//}
//
//// MARK: - MapView
//struct MapView: View {
//    @State private var showFloorSelector = false
//    @State private var selectedFloor = "None"
//    @State private var selectedRoom: Room? = nil
//
//    // Example tappable rooms for Ground floor map
//    let groundRooms: [Room] = [
//        Room(name: "Lecture Hall A", frame: CGRect(x: 60, y: 30, width: 110, height: 70)),
//        Room(name: "Lecture Hall B", frame: CGRect(x: 230, y: 30, width: 100, height: 70)),
//        Room(name: "Lecture Hall C", frame: CGRect(x: 60, y: 250, width: 100, height: 70)),
//        Room(name: "Lecture Hall D", frame: CGRect(x: 230, y: 250, width: 100, height: 70)),
//    ]
//
//    var body: some View {
//        ZStack {
//            VStack {
//                // Page Title
//                Text("Map")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.top, 50)
//
//                // Current Floor
//                if selectedFloor != "None" {
//                    Text("Selected Floor: \(selectedFloor)")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        .padding(.top, 10)
//                }
//
//                Spacer()
//
//                // Floor Content
//                if selectedFloor == "Ground" {
//                    ZStack {
//                        GeometryReader { geo in
//                            let imageWidth: CGFloat = 402 // Actual width of GroundMap.png
//                            let scale = geo.size.width / imageWidth
//
//                            // Base Map
//                            Image("GroundMap")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: geo.size.width)
//                                .clipped()
//
//                            // Interactive Rooms
//                            ForEach(groundRooms) { room in
//                                let scaledFrame = CGRect(
//                                    x: room.frame.origin.x * scale,
//                                    y: room.frame.origin.y * scale,
//                                    width: room.frame.width * scale,
//                                    height: room.frame.height * scale
//                                )
//
//                                ZStack {
//                                    // Tappable Rectangle
//                                    Rectangle()
//                                        .fill(selectedRoom?.id == room.id ? Color.blue.opacity(0.3) : Color.clear)
//                                        .border(Color.blue, width: selectedRoom?.id == room.id ? 2 : 0)
//                                        .frame(width: scaledFrame.width, height: scaledFrame.height)
//                                        .position(x: scaledFrame.midX, y: scaledFrame.midY)
//                                        .onTapGesture {
//                                            selectedRoom = room
//                                        }
//
//                                    // Popup on top
//                                    if selectedRoom?.id == room.id {
//                                        Text(room.name)
//                                            .font(.caption)
//                                            .padding(6)
//                                            .background(Color.white)
//                                            .cornerRadius(8)
//                                            .shadow(radius: 3)
//                                            .position(
//                                                x: scaledFrame.midX,
//                                                y: scaledFrame.minY - 14
//                                            )
//                                    }
//                                }
//                            }
//                        }
//                        .frame(height: 600)
//                        .padding()
//                    }
//                } else {
//                    // Placeholder for other floors
//                    Image(systemName: "globe.americas.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(.blue.opacity(0.3))
//                        .frame(width: 200, height: 200)
//                        .background(Color.gray.opacity(0.1))
//                        .clipShape(Circle())
//                        .padding()
//                }
//
//                Spacer()
//
//                // Floor Selector
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
//                .padding(.bottom, 90)
//                .confirmationDialog("Select a Floor", isPresented: $showFloorSelector, titleVisibility: .visible) {
//                    Button("Ground") {
//                        selectedFloor = "Ground"
//                        selectedRoom = nil
//                    }
//                    Button("First Floor") { selectedFloor = "First Floor" }
//                    Button("Second Floor") { selectedFloor = "Second Floor" }
//                    Button("Cancel", role: .cancel) {}
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.all)
//        .animation(.easeInOut, value: selectedRoom)
//    }
//}
//
//// MARK: - Preview
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

//import SwiftUI
//
//// MARK: - Room Model
//struct Room: Identifiable, Equatable {
//    let id = UUID()
//    let name: String
//    let frame: CGRect
//
//    static func == (lhs: Room, rhs: Room) -> Bool {
//        lhs.id == rhs.id
//    }
//}
//
//// MARK: - Map View
//struct MapView: View {
//    @State private var showFloorSelector = false
//    @State private var selectedFloor = "None"
//    @State private var selectedRoom: Room? = nil
//
//    // Sample rooms for the Ground floor (based on 402x509 image)
//    let groundRooms: [Room] = [
//        Room(name: "Lecture Hall A", frame: CGRect(x: 60, y: 30, width: 110, height: 70)),
//        Room(name: "Lecture Hall B", frame: CGRect(x: 230, y: 30, width: 100, height: 70)),
//        Room(name: "Lecture Hall C", frame: CGRect(x: 60, y: 250, width: 100, height: 70)),
//        Room(name: "Lecture Hall D", frame: CGRect(x: 230, y: 250, width: 100, height: 70)),
//    ]
//
//    var body: some View {
//        ZStack {
//            VStack {
//                // Title
//                Text("Map")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.top, 50)
//
//                if selectedFloor != "None" {
//                    Text("Selected Floor: \(selectedFloor)")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        .padding(.top, 10)
//                }
//
//                Spacer()
//
//                if selectedFloor == "Ground" {
//                    ZStack {
//                        GeometryReader { geo in
//                            let imageWidth: CGFloat = 402
//                            let scale = geo.size.width / imageWidth
//
//                            // Map image
//                            Image("GroundMap")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: geo.size.width)
//                                .clipped()
//
//                            // Overlay rooms
//                            ForEach(groundRooms) { room in
//                                let scaledFrame = CGRect(
//                                    x: room.frame.origin.x * scale,
//                                    y: room.frame.origin.y * scale,
//                                    width: room.frame.width * scale,
//                                    height: room.frame.height * scale
//                                )
//
//                                ZStack(alignment: .top) {
//                                    Rectangle()
//                                        .fill(selectedRoom?.id == room.id ? Color.blue.opacity(0.3) : Color.clear)
//                                        .border(Color.blue, width: selectedRoom?.id == room.id ? 2 : 0)
//                                        .frame(width: scaledFrame.width, height: scaledFrame.height)
//                                        .onTapGesture {
//                                            selectedRoom = room
//                                        }
//
//                                    // Room label popup
//                                    if selectedRoom?.id == room.id {
//                                        Text(room.name)
//                                            .font(.caption)
//                                            .padding(6)
//                                            .background(Color.white)
//                                            .cornerRadius(8)
//                                            .shadow(radius: 4)
//                                            .offset(y: -30)
//                                    }
//                                }
//                                .frame(width: scaledFrame.width, height: scaledFrame.height)
//                                .position(x: scaledFrame.midX, y: scaledFrame.midY)
//                            }
//                        }
//                        .frame(height: 600)
//                        .padding()
//                    }
//                } else {
//                    // Placeholder
//                    Image(systemName: "globe.americas.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(.blue.opacity(0.3))
//                        .frame(width: 200, height: 200)
//                        .background(Color.gray.opacity(0.1))
//                        .clipShape(Circle())
//                        .padding()
//                }
//
//                Spacer()
//
//                // Floor select
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
//                .padding(.bottom, 90)
//                .confirmationDialog("Select a Floor", isPresented: $showFloorSelector, titleVisibility: .visible) {
//                    Button("Ground") {
//                        selectedFloor = "Ground"
//                        selectedRoom = nil
//                    }
//                    Button("First Floor") { selectedFloor = "First Floor" }
//                    Button("Second Floor") { selectedFloor = "Second Floor" }
//                    Button("Cancel", role: .cancel) {}
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.all)
//        .animation(.easeInOut, value: selectedRoom)
//    }
//}
//
//// MARK: - Preview
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

//import SwiftUI
//
//// MARK: - Room Model
//struct Room: Identifiable, Equatable {
//    let id = UUID()
//    let name: String
//    let frame: CGRect
//
//    static func == (lhs: Room, rhs: Room) -> Bool {
//        lhs.id == rhs.id
//    }
//}
//
//// MARK: - Map View
//struct MapView: View {
//    @State private var showFloorSelector = false
//    @State private var selectedFloor = "Ground"
//    @State private var selectedRoom: Room? = nil
//
//    // Room frames based on original image size 402x509
//    let groundRooms: [Room] = [
//        Room(name: "Lecture Hall A", frame: CGRect(x: 60, y: 30, width: 110, height: 70)),
//        Room(name: "Lecture Hall B", frame: CGRect(x: 230, y: 30, width: 100, height: 70)),
//        Room(name: "Lecture Hall C", frame: CGRect(x: 60, y: 250, width: 100, height: 70)),
//        Room(name: "Lecture Hall D", frame: CGRect(x: 230, y: 250, width: 100, height: 70)),
//    ]
//
//    var body: some View {
//        VStack {
//            Text("Map")
//                .font(.largeTitle)
//                .bold()
//                .padding(.top, 50)
//
//            if selectedFloor != "None" {
//                Text("Selected Floor: \(selectedFloor)")
//                    .font(.headline)
//                    .foregroundColor(.gray)
//                    .padding(.top, 10)
//            }
//
//            Spacer()
//
//            if selectedFloor == "Ground" {
//                GeometryReader { geo in
//                    let imageWidth: CGFloat = 402
//                    let imageHeight: CGFloat = 509
//                    let scale = geo.size.width / imageWidth
//
//                    ZStack {
//                        // Floor image
//                        Image("GroundMap")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geo.size.width)
//
//                        // Overlay tappable rooms
//                        ForEach(groundRooms) { room in
//                            let scaled = CGRect(
//                                x: room.frame.origin.x * scale,
//                                y: room.frame.origin.y * scale,
//                                width: room.frame.width * scale,
//                                height: room.frame.height * scale
//                            )
//
//                            ZStack {
//                                // Highlight
//                                Rectangle()
//                                    .fill(selectedRoom?.id == room.id ? Color.blue.opacity(0.3) : Color.clear)
//                                    .border(Color.blue, width: selectedRoom?.id == room.id ? 2 : 0)
//                                    .frame(width: scaled.width, height: scaled.height)
//                                    .position(x: scaled.midX, y: scaled.midY)
//                                    .onTapGesture {
//                                        selectedRoom = room
//                                    }
//
//                                // Popup label
//                                if selectedRoom?.id == room.id {
//                                    Text(room.name)
//                                        .font(.caption)
//                                        .padding(6)
//                                        .background(Color.white)
//                                        .cornerRadius(6)
//                                        .shadow(radius: 3)
//                                        .position(
//                                            x: scaled.midX,
//                                            y: scaled.minY - 15
//                                        )
//                                }
//                            }
//                        }
//                    }
//                }
//                .frame(height: 600)
//                .padding()
//            } else {
//                Image(systemName: "globe.americas.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//                    .foregroundColor(.blue.opacity(0.3))
//                    .background(Color.gray.opacity(0.1))
//                    .clipShape(Circle())
//                    .padding()
//            }
//
//            Spacer()
//
//            // Floor selection
//            Button(action: {
//                showFloorSelector = true
//            }) {
//                Text("Floor Select")
//                    .fontWeight(.semibold)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//                    .padding(.horizontal)
//            }
//            .padding(.bottom, 90)
//            .confirmationDialog("Select a Floor", isPresented: $showFloorSelector, titleVisibility: .visible) {
//                Button("Ground") {
//                    selectedFloor = "Ground"
//                    selectedRoom = nil
//                }
//                Button("First Floor") { selectedFloor = "First Floor" }
//                Button("Second Floor") { selectedFloor = "Second Floor" }
//                Button("Cancel", role: .cancel) {}
//            }
//        }
//        .edgesIgnoringSafeArea(.all)
//        .animation(.easeInOut, value: selectedRoom)
//    }
//}
//
//// MARK: - Preview
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

