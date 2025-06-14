//
//  CampusNavigatorApp.swift
//  CampusNavigator
//
//  Created by Chanuka Wijesooriya  on 2025-06-07.
//

import SwiftUI

@main
struct CampusNavigatorApp: App {
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
