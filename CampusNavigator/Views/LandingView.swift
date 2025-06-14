import SwiftUI

struct LaningView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 38) {
                    
                    // Greeting Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hi, Geeneth")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Welcome to Campus Navigator")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image("profile_picture") // Add this to Assets
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal)
                    
                    // Upcoming Events Carousel
                    TabView {
                        Image("event_banner") // Example banner image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                    .frame(height: 150)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .padding(.horizontal)

                    // Feature Icon Grid
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            FeatureButton(title: "View Campus Map", iconName: "map-icon", description: "Explore buildings, departments, and wayfinding.")
                            FeatureButton(title: "Check Crowd Levels", iconName: "crowd-icon", description: "Live density data for libraries, cafeterias, gyms.")
                        }
                        HStack(spacing: 16) {
                            FeatureButton(title: "Reserve a Space", iconName: "reserve-icon", description: "Book study rooms, labs, parking slots.")
                            FeatureButton(title: "Exams and Results", iconName: "exam-icon", description: "Check your results and exam schedules.")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 36)
                    .padding(.bottom, 18)
                    .background(Color(red: 0.87, green: 0.87, blue: 0.87).opacity(0.7))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                }
                .padding(.top)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FeatureButton: View {
    var title: String
    var iconName: String
    var description: String

    var body: some View {
        VStack(spacing: 8) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(description)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
        .frame(width: 150, height: 160) // Set fixed size for each box
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}

#Preview{
    LaningView()
}
