import SwiftUI

struct ExamsAndResultsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // Title
                HStack {
                    Text("Exams and Results")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 24)
                
                // Content Grid
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    NavigationLink(destination: RepeatExamView()){
                        ExamCard(
                            imageName: "RepeatExamIcon",
                            title: "Repeat exams",
                            subtitle: "View to apply repeat exams and download...",
                            backgroundColor: Color(red: 0.85, green: 0.85, blue: 0.85)
                        )
                    }
                    
                    NavigationLink(destination: UpcomingExamsView()){
                        ExamCard(
                            imageName: "UpcomingExamIcon",
                            title: "Upcoming exams",
                            subtitle: "Check your exam schedule with module...",
                            backgroundColor: Color(red: 0.85, green: 0.85, blue: 0.85)
                        )
                    }
                    
                    NavigationLink(destination: ExamResultsView()) {
                        ExamCard(
                            imageName: "ExamResultsIcon",
                            title: "Exam results",
                            subtitle: "View your latest results for each module...",
                            backgroundColor: Color(red: 0.85, green: 0.85, blue: 0.85)
                        )
                    }
                    
//                    NavigationLink(destination: ){
                        ExamCard(
                            imageName: "ExamScheduleIcon",
                            title: "Exam Schedule",
                            subtitle: "View updated exam schedules",
                            backgroundColor: Color(red: 0.85, green: 0.85, blue: 0.85)
                        )
//                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}


struct ExamCard: View {
    let imageName: String
    let title: String
    let subtitle: String
    let backgroundColor: Color
    
    var body: some View {
        VStack(spacing: 0) {
            // Image container
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                    .frame(height: 158)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 156, height: 158)
                    .clipped()
            }
            .cornerRadius(10, corners: [.topLeft, .topRight])
            
            // Text container
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
        }
        .frame(width: 176, height: 241)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
    }
}

// Extension to add corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Preview
struct ExamsAndResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ExamsAndResultsView()
    }
}
