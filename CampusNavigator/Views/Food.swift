//
//  Food.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-14.
//

import SwiftUI

struct CafeteriaMainView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // Title and Cart Icon
                HStack {
                    Text("Cafeteria")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        // Cart action
                    }) {
                        Image(systemName: "cart")
                            .font(.title2)
                    }
                }
                .padding(.top)

                // Tile 1 - Foods & Beverages
                NavigationLink(destination: Text("Foods & Beverages Page")) {
                    HStack(spacing: 16) {
                        Image(systemName: "fork.knife")
                            .font(.title2)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("Foods & Beverages")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("Select your order")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                // Tile 2 - Your Orders
                NavigationLink(destination: Text("Your Orders Page")) {
                    HStack(spacing: 16) {
                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("Your Orders")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("View your ongoing and past orders")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(false)
        }
    }
}

#Preview {
    CafeteriaMainView()
}
