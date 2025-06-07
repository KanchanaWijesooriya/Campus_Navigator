import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Header with Title and Profile Picture
                    HStack {
                        Text("Campus Navigator")
                            .font(.title)
                            .bold()

                        Spacer()

                        Image("profilePic") // Replace with your asset name
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity)

                    // Cards Section
                    VStack(spacing: 16) {
                        HomeTile(title: "View Campus Map", subtitle: "Explore buildings, departments, and wayfinding.")
                        HomeTile(title: "Check Crowd Levels", subtitle: "Live density data for libraries, cafeterias, gyms.")
                        HomeTile(title: "Reserve a Space", subtitle: "Book study rooms, labs, parking slots.")
                        HomeTile(title: "My Timetable", subtitle: "Explore buildings, departments, and wayfinding.")
                        HomeTile(title: "Exams and Results", subtitle: "Repeat exams, module results, and upcoming exams.")
                    }
                }
                .padding()
            }
        }
    }
}

struct HomeTile: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        Button(action: {
            // Placeholder for future navigation
        }) {
            HStack(alignment: .top, spacing: 16) {
                Rectangle() // Placeholder for icon
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .foregroundColor(.gray.opacity(0.3))

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

#Preview {
    HomeView()
}

