import SwiftUI

struct LandingView: View {
    @State private var currentTab = 0
    private let banners = ["event_banner1", "event_banner2", "event_banner3"]
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 32) {

                    // Greeting Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hi, Devmi")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Welcome to Campus Navigator")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        NavigationLink(destination: ProfileView()){
                            Image("profile_picture") // Add to Assets
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)

                    // Upcoming Events Carousel
                    TabView(selection: $currentTab) {
                        ForEach(0..<banners.count, id: \.self) { index in
                            Image(banners[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150)
                                .clipped()
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 160)
                    .onReceive(timer) { _ in
                        withAnimation {
                            currentTab = (currentTab + 1) % banners.count
                        }
                    }

                    // Explore App Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Explore App...")
                            .font(.headline)
                            .padding(.leading)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            NavigationLink(destination: MapView()){
                                FeatureButton(
                                    title: "View Campus Map",
                                    iconName: "map-icon",
                                    description: "Explore buildings, departments, and wayfinding."
                                )
                            }
                            NavigationLink(destination: CrowdLevelsView()){
                                FeatureButton(
                                    title: "Check Crowd Levels",
                                    iconName: "crowd-icon",
                                    description: "Live density data for libraries, cafeterias, gyms."
                                )
                            }
                            NavigationLink(destination: ReserveSpacePage()){
                                FeatureButton(
                                    title: "Reserve a Space",
                                    iconName: "reserve-icon",
                                    description: "Book study rooms, labs, parking slots."
                                )
                            }
                            NavigationLink(destination: ExamsAndResultsView()){
                                FeatureButton(
                                    title: "Exams and Results",
                                    iconName: "exam-icon",
                                    description: "Check your results and exam schedules."
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(Color(red: 0.87, green: 0.87, blue: 0.87).opacity(0.7))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct FeatureButton: View {
    var title: String
    var iconName: String
    var description: String

    var body: some View {
        VStack(spacing: 10) {
            Image(iconName)
                .resizable()
                .frame(width: 40, height: 38)
                .overlay(
                    Rectangle()
                        .stroke(Color.gray.opacity(0.4), lineWidth: 2)
                )

            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(description)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .frame(maxHeight: 40) // prevents stretching from longer descriptions
        }
        .frame(width: 145, height: 155)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}


#Preview{
    LandingView()
}
