import SwiftUI

// MARK: - Constants
struct Constants {
    static let LabelsPrimary: Color = .black
    static let newTextGray: Color = Color(red: 0.5, green: 0.51, blue: 0.57)
}

// MARK: - HomeView
struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // Top Navigation Bar
                HStack {
                    Button(action: {}) {
                        Text("Back")
                            .foregroundColor(.blue)
                    }

                    Spacer()

                    Text("Home")
                        .font(.custom("Inter", size: 17).weight(.semibold))
                        .foregroundColor(Constants.LabelsPrimary)

                    Spacer()

                    Image("profile-icon") // <- ADD to Assets
                        .resizable()
                        .frame(width: 35, height: 35)
                        .background(Constants.newTextGray)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                .padding(.top)

                // App Title
                Text("Campus Navigator")
                    .font(.custom("Inter", size: 32).weight(.bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Feature Cards
                VStack(spacing: 16) {
                    FeatureCard(iconName: "map-icon", title: "View Campus Map", description: "Explore buildings, departments, and wayfinding.")
                    FeatureCard(iconName: "crowd-icon", title: "Check Crowd Levels", description: "Live density data for libraries, cafeterias, gyms.")
                    FeatureCard(iconName: "reserve-icon", title: "Reserve a Space", description: "Book study rooms, labs, .")
                    FeatureCard(iconName: "timetable-icon", title: "My Timetable", description: "Explore buildings, departments, and wayfinding.")
                    FeatureCard(iconName: "exam-icon", title: "Exams and Results", description: "Repeat exams, module results, and upcoming exams.")
                }
                .padding(.horizontal)

                Spacer()

                // Bottom Tab Bar (Placeholder)
                HStack {
                    TabBarIcon(name: "Map")
                    TabBarIcon(name: "My Events")
                    TabBarIcon(name: "Home", isSelected: true)
                    TabBarIcon(name: "Crowd Levels")
                    TabBarIcon(name: "Foods")
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
            }
        }
    }
}

// MARK: - Feature Card
struct FeatureCard: View {
    var iconName: String
    var title: String
    var description: String

    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32) // Balanced size
                .padding(.top, 12)
                .padding(.leading, 12)

            // Text Block
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.custom("Inter", size: 17).weight(.semibold))
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)

                Text(description)
                    .font(.custom("Inter", size: 15))
                    .foregroundColor(Constants.newTextGray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 12)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.87, green: 0.87, blue: 0.87).opacity(0.7))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 2)
        .frame(width: 351, height: 92)
    }
}

// MARK: - Bottom Tab Bar Icon
struct TabBarIcon: View {
    var name: String
    var isSelected: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: isSelected ? "house.fill" : "house") // Replace with custom tab icons if needed
                .font(.title2)
            Text(name)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(isSelected ? .blue : .gray)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
