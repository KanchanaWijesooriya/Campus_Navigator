//
//  MainTabView.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-13.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }

            ProfileView()
                .tabItem {
                    Label("My Events", systemImage: "calendar")
                }

            HomeView() // Or replace with ProfileView() if needed
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            CrowdLevelsView()
                .tabItem {
                    Label("Crowd", systemImage: "person.3.fill")
                }

            FoodBeveragesView(cartManager: CartManager())
                .tabItem {
                    Label("Food", systemImage: "cart")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
