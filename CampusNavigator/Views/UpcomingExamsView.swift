//import SwiftUI
//
//struct UpcomingExamView: View {
//    let examResults: [ExamResult] = [
//        ExamResult(module: "PDSA 2", marks: 75),
//        ExamResult(module: "TSLE", marks: 84),
//        ExamResult(module: "Data Science", marks: 88),
//        ExamResult(module: "Cyber Security", marks: 75),
//        ExamResult(module: "DU", marks: 86),
//        ExamResult(module: "ECS", marks: 87),
//        ExamResult(module: "iOS", marks: nil),
//        ExamResult(module: "Web API", marks: nil)
//    ]
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 16) {
//                    headerView
//                    
//                    resultsCardView
//                    
//                    additionalContentPlaceholder
//                }
//                .padding(.horizontal, 16)
//                .padding(.top, 8)
//            }
//            .navigationTitle("Exam Results")
//            .navigationBarTitleDisplayMode(.large)
//            .background(Color(.systemGroupedBackground))
//        }
//    }
//    
//    private var headerView: some View {
//        HStack {
//            Spacer()
//            VStack(alignment: .trailing, spacing: 4) {
//                Text(Date.now.formatted(date: .abbreviated, time: .omitted))
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                Text(Date.now.formatted(date: .omitted, time: .shortened))
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
//            .padding(10)
//            .background(Color(.systemBackground))
//            .cornerRadius(8)
//        }
//    }
//    
//    private var resultsCardView: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            ForEach(examResults) { result in
//                ExamResultRow(result: result)
//                
//                if result.id != examResults.last?.id {
//                    Divider()
//                        .padding(.leading, 16)
//                }
//            }
//        }
//        .background(Color(.systemBackground))
//        .cornerRadius(10)
//    }
//    
//    private var additionalContentPlaceholder: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            Text("Additional Information")
//                .font(.headline)
//                .padding(16)
//            
//            Divider()
//            
//            VStack(spacing: 16) {
//                Text("Map")
//                Text("My Events")
//                Text("Home")
//                Text("Crowd Levels")
//                Text("Foods")
//            }
//            .padding(16)
//        }
//        .background(Color(.systemBackground))
//        .cornerRadius(10)
//    }
//}
//
//struct ExamResultRow: View {
//    let result: ExamResult
//    
//    var body: some View {
//        HStack(alignment: .center, spacing: 0) {
//            Text(result.module)
//                .font(.body)
//                .padding(.vertical, 14)
//                .padding(.leading, 16)
//            
//            Spacer()
//            
//            if let marks = result.marks {
//                Text("\(marks)")
//                    .font(.body.monospacedDigit())
//                    .foregroundColor(marksColor(marks: marks))
//                    .padding(.trailing, 16)
//            } else {
//                Text("-")
//                    .font(.body)
//                    .foregroundColor(.secondary)
//                    .padding(.trailing, 16)
//            }
//        }
//    }
//    
//    private func marksColor(marks: Int) -> Color {
//        switch marks {
//        case 0..<50: return .red
//        case 50..<70: return .orange
//        case 70..<90: return .green
//        case 90...100: return .blue
//        default: return .primary
//        }
//    }
//}
//
//struct ExamResult: Identifiable {
//    let id = UUID()
//    let module: String
//    let marks: Int?
//}
//
//struct UpcomingExamView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingExamView()
//    }
//}

import SwiftUI

// MARK: - Model
struct Exam: Identifiable {
    let id = UUID()
    let moduleName: String
    let lectureHall: String
    let date: Date
    let startTime: Date
}

// MARK: - Sample Data
let sampleExams: [Exam] = [
    Exam(moduleName: "Mathematics 101", lectureHall: "LH 2", date: Date().addingTimeInterval(86400), startTime: Date().addingTimeInterval(86400 + 3600)),
    Exam(moduleName: "Physics 201", lectureHall: "LH 3", date: Date().addingTimeInterval(172800), startTime: Date().addingTimeInterval(172800 + 7200)),
    Exam(moduleName: "Computer Science 301", lectureHall: "LH 1", date: Date().addingTimeInterval(259200), startTime: Date().addingTimeInterval(259200 + 5400))
]

// MARK: - View
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

// MARK: - Preview
struct UpcomingExamsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingExamsView()
    }
}
