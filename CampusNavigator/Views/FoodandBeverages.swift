//
//  FoodandBeverages.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-13.
//

import SwiftUI

// MARK: - Data Model
struct FoodItem: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let imageName: String
    let price: Double
    var quantity: Int
}

// MARK: - Cart Manager with Persistence
class CartManager: ObservableObject {
    @Published var items: [FoodItem] = [] {
        didSet {
            saveCart()
        }
    }

    private let cartKey = "saved_cart"

    init() {
        loadCart()
    }

    func addToCart(_ item: FoodItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += item.quantity
        } else {
            items.append(item)
        }
    }

    func removeFromCart(_ item: FoodItem) {
        items.removeAll { $0.id == item.id }
    }

    func clearCart() {
        items.removeAll()
    }

    private func saveCart() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }

    private func loadCart() {
        if let savedData = UserDefaults.standard.data(forKey: cartKey),
           let decoded = try? JSONDecoder().decode([FoodItem].self, from: savedData) {
            items = decoded
        }
    }
}

// MARK: - Cart View
struct CartView: View {
    @ObservedObject var cartManager: CartManager

    var total: Double {
        cartManager.items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }

    var body: some View {
        VStack {
            if cartManager.items.isEmpty {
                Text("Your cart is empty.")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(cartManager.items, id: \.self) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text("Qty: \(item.quantity) x $\(String(format: "%.2f", item.price))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(String(format: "$%.2f", Double(item.quantity) * item.price))
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = cartManager.items[index]
                            cartManager.removeFromCart(item)
                        }
                    }
                }

                HStack {
                    Text("Total:")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", total))
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding()

                Button("Checkout") {
                    cartManager.clearCart()
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding([.horizontal, .bottom])
            }
        }
        .navigationTitle("Your Cart")
    }
}

// MARK: - Main Menu View
struct FoodBeveragesView: View {
    @ObservedObject var cartManager: CartManager

    @State private var items: [FoodItem] = [
        FoodItem(id: UUID(), name: "Cheeseburger", imageName: "burger", price: 5.99, quantity: 0),
        FoodItem(id: UUID(), name: "Pizza Slice", imageName: "pizza", price: 3.49, quantity: 0),
        FoodItem(id: UUID(), name: "Iced Coffee", imageName: "coffee", price: 2.99, quantity: 0),
        FoodItem(id: UUID(), name: "Lemonade", imageName: "lemonade", price: 1.99, quantity: 0),
        FoodItem(id: UUID(), name: "French Fries", imageName: "fries", price: 2.49, quantity: 0)
    ]

    var selectedItems: [FoodItem] {
        items.filter { $0.quantity > 0 }
    }

    var totalSelectedPrice: Double {
        selectedItems.reduce(0) { $0 + Double($1.quantity) * $1.price }
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(items.indices, id: \.self) { index in
                            HStack(spacing: 16) {
                                Image(items[index].imageName)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)

                                VStack(alignment: .leading) {
                                    Text(items[index].name)
                                        .font(.headline)
                                    Text("$\(items[index].price, specifier: "%.2f")")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Stepper("Qty: \(items[index].quantity)", value: $items[index].quantity, in: 0...10)
                                    .labelsHidden()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }

                if !selectedItems.isEmpty {
                    VStack(spacing: 8) {
                        Text("Selected Items: \(selectedItems.count)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(String(format: "Total: $%.2f", totalSelectedPrice))
                            .font(.headline)

                        Button("Add to Cart") {
                            for item in selectedItems {
                                cartManager.addToCart(item)
                            }
                            // Reset quantities
                            items = items.map {
                                var updated = $0
                                updated.quantity = 0
                                return updated
                            }
                        }
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Foods & Beverages")
            .toolbar {
                NavigationLink(destination: CartView(cartManager: cartManager)) {
                    Label("Cart", systemImage: "cart")
                }
            }
        }
    }
}

// MARK: - Preview
struct FoodBeveragesView_Previews: PreviewProvider {
    static var previews: some View {
        FoodBeveragesView(cartManager: CartManager())
    }
}
