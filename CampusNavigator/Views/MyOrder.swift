
import SwiftUI

struct Order: Identifiable {
    let id = UUID()
    let orderNumber: String
    let timeReceived: String
    let completedTime: String
    let items: [String]
    let orderDate: String
    let total: String
}

struct MyOrdersView: View {
    let orders: [Order] = [
        Order(orderNumber: "001021", timeReceived: "12:00 P.M.", completedTime: "01:05 P.M.", items: ["Fried Rice Chicken x 1", "Lime Juice x 1"], orderDate: "2025-06-07", total: "LKR 750"),
        Order(orderNumber: "001022", timeReceived: "12:00 P.M.", completedTime: "01:05 P.M.", items: ["Rice and Curry - Chicken x 1", "Smoothie x 1"], orderDate: "2025-06-07", total: "LKR 750"),
        Order(orderNumber: "001022", timeReceived: "12:00 P.M.", completedTime: "01:05 P.M.", items: ["Rice and Curry - Chicken x 1", "Smoothie x 1"], orderDate: "2025-06-07", total: "LKR 750")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(orders) { order in
                            OrderCard(order: order)
                        }
                    }
                    .padding()
                }

                Button(action: {
                    // Confirm order action
                }) {
                    Text("Confirm Order")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
            }
            .navigationTitle("My Orders")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct OrderCard: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Order #\(order.orderNumber)")
                .fontWeight(.semibold)

            Text("Time received: \(order.timeReceived)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Completed Time: \(order.completedTime)")
                .font(.subheadline)
                .foregroundColor(.gray)

            ForEach(order.items, id: \.self) { item in
                Text("• \(item)")
            }

            Text("Order Date: \(order.orderDate)")
                .font(.footnote)
                .foregroundColor(.gray)

            HStack {
                Spacer()
                Text("Total: \(order.total)")
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    MyOrdersView()
}
