import SwiftUI


struct Exam: Identifiable {
    let id = UUID()
    let moduleName: String
    let lectureHall: String
    let date: Date
    let startTime: Date
}


let sampleExams: [Exam] = [
    Exam(moduleName: "Mathematics 101", lectureHall: "LH 2", date: Date().addingTimeInterval(86400), startTime: Date().addingTimeInterval(86400 + 3600)),
    Exam(moduleName: "Physics 201", lectureHall: "LH 3", date: Date().addingTimeInterval(172800), startTime: Date().addingTimeInterval(172800 + 7200)),
    Exam(moduleName: "Computer Science 301", lectureHall: "LH 1", date: Date().addingTimeInterval(259200), startTime: Date().addingTimeInterval(259200 + 5400))
]


struct UpcomingExamsView: View {
    let exams: [Exam] = sampleExams
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(exams) { exam in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(exam.moduleName)
                                .font(.title3)
                                .fontWeight(.semibold)

                            HStack {
                                Label(exam.lectureHall, systemImage: "building.2.crop.circle")
                                Spacer()
                                Label(dateFormatter.string(from: exam.date), systemImage: "calendar")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                            HStack {
                                Label(timeFormatter.string(from: exam.startTime), systemImage: "clock")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 32)
                }
                .padding(.top, 16)
            }
            .navigationTitle("Upcoming Exams")
        }
    }
}


struct UpcomingExamsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingExamsView()
    }
}
