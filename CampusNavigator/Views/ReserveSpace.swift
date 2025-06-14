import SwiftUI

struct ReserveSpacePage: View {
    @State private var selectedTab = 0
    @State private var reservedPCs: [String] = []

    let pcs = ["PC 1", "PC 2", "PC 3", "PC 4", "PC 5", "PC 6", "PC 7", "PC 8", "PC 9", "PC 10", "PC 11", "PC 12"]

    var body: some View {
        VStack {
            Text("Reserve Space")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)

            // Tabs
            Picker("Tabs", selection: $selectedTab) {
                Text("Available PCs").tag(0)
                Text("My Reservations").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Content
            TabView(selection: $selectedTab) {
                // Tab 1: Available PCs
                List(pcs, id: \.self) { pc in
                    HStack(spacing: 12) {
                        Image(systemName: "desktopcomputer")
                            .foregroundColor(.blue)
                        
                        Text(pc)
                            .fontWeight(.medium)
                        
                        Spacer()

                        if reservedPCs.contains(pc) {
                            Text("Reserved")
                                .foregroundColor(.gray)
                                .font(.caption)
                        } else {
                            Button("Available") {
                                reservedPCs.append(pc)
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .tag(0)

                // Tab 2: My Reservations
                List {
                    if reservedPCs.isEmpty {
                        Text("You have no reservations.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(reservedPCs, id: \.self) { pc in
                            HStack(spacing: 12) {
                                Image(systemName: "desktopcomputer")
                                    .foregroundColor(.blue)
                                Text(pc)
                            }
                        }
                    }
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    ReserveSpacePage()
}
