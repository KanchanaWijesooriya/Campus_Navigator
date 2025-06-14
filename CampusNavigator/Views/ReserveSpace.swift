

import SwiftUI

struct Reservation: Identifiable, Equatable {
    let id = UUID()
    let pcName: String
    let date: Date
}

struct ReserveSpacePage: View {
    @State private var selectedTab = 0
    @State private var reservations: [Reservation] = []
    @State private var showDatePicker = false
    @State private var selectedPC: String = ""
    @State private var tempDate = Date()

    let pcs = ["PC 1", "PC 2", "PC 3", "PC 4", "PC 5", "PC 6", "PC 7", "PC 8", "PC 9", "PC 10", "PC 11", "PC 12"]

    var body: some View {
        VStack {
            Text("Reserve Space")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 100)
                .padding(.trailing, 150)

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

                        if reservations.contains(where: { $0.pcName == pc }) {
                            Text("Reserved")
                                .foregroundColor(.gray)
                                .font(.caption)
                        } else {
                            Button("Available") {
                                selectedPC = pc
                                tempDate = Date()
                                showDatePicker = true
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .tag(0)

                // Tab 2: My Reservations
                List {
                    if reservations.isEmpty {
                        Text("You have no reservations.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(reservations) { reservation in
                            HStack(spacing: 12) {
                                Image(systemName: "desktopcomputer")
                                    .foregroundColor(.blue)

                                VStack(alignment: .leading) {
                                    Text(reservation.pcName)
                                        .fontWeight(.medium)
                                    Text("Date: \(formattedDate(reservation.date))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Button(action: {
                                    reservations.removeAll { $0 == reservation }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .sheet(isPresented: $showDatePicker) {
            VStack(spacing: 20) {
                Text("Select Reservation Date")
                    .font(.headline)

                DatePicker("Reservation Date", selection: $tempDate, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()

                Button("Confirm Reservation") {
                    let newReservation = Reservation(pcName: selectedPC, date: tempDate)
                    reservations.append(newReservation)
                    showDatePicker = false
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)

                Button("Cancel") {
                    showDatePicker = false
                }
                .foregroundColor(.red)
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
    }

    // Format date for display
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ReserveSpacePage()
}
