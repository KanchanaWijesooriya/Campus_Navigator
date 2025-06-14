import SwiftUI

enum Tab {
    case map, events, landing, crowd, food
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .landing  // default tab selected

    var body: some View {
        TabView(selection: $selectedTab) {
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(Tab.map)

            NewsFeedView()
                .tabItem {
                    Label("My Events", systemImage: "calendar")
                }
                .tag(Tab.events)

            LandingView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.landing)

            CrowdLevelsView()
                .tabItem {
                    Label("Crowd", systemImage: "person.3.fill")
                }
                .tag(Tab.crowd)

            FoodBeveragesView(cartManager: CartManager())
                .tabItem {
                    Label("Food", systemImage: "cart")
                }
                .tag(Tab.food)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

