import SwiftUI

struct UpcomingExamsView: View {
    // Constants for styling
    private struct Constants {
        static let systemLabelPrimary: Color = .black
        static let newLoginInput: Color = Color(red: 0.96, green: 0.97, blue: 1)
        static let newTextGray: Color = Color(red: 0.5, green: 0.51, blue: 0.57)
        static let cardCornerRadius: CGFloat = 20
        static let horizontalPadding: CGFloat = 16
        static let cardHeight: CGFloat = 104
        static let cardWidth: CGFloat = 357
        static let spacingBetweenCards: CGFloat = 12
    }
    
    // Exam data model
    struct Exam: Identifiable {
        let id = UUID()
        let course: String
        let date: String
        let location: String
        let time: String
    }
    
    // Sample data
    private let exams: [Exam] = [
        Exam(course: "PDSA-2", date: "2025/08/17", location: "Auditorium", time: "1 P.M - 3 P.M"),
        Exam(course: "TLSE", date: "2025/08/18", location: "Auditorium", time: "1 P.M - 3 P.M")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.spacingBetweenCards) {
                    ForEach(exams) { exam in
                        examCard(exam: exam)
                    }
                }
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.top, 20)
            }
            .navigationTitle("Upcoming Exams")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    // Reusable exam card component
    private func examCard(exam: Exam) -> some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .fill(Constants.newLoginInput)
                .frame(width: Constants.cardWidth, height: Constants.cardHeight)
            
            // Card content
            VStack(alignment: .leading, spacing: 8) {
                // Course name
                Text(exam.course)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Constants.systemLabelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Date
                Text(exam.date)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Constants.newTextGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 16) {
                    // Location
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Location")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Constants.newTextGray)
                        Text(exam.location)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Constants.systemLabelPrimary)
                    }
                    
                    // Time
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Time")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Constants.newTextGray)
                        Text(exam.time)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Constants.newTextGray)
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(width: Constants.cardWidth, height: Constants.cardHeight, alignment: .topLeading)
        }
    }
}

// Preview provider
struct UpcomingExamsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingExamsView()
    }
}

