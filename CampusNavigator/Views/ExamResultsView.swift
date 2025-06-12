import SwiftUI

struct ExamResultsView: View {
    let examResults = [
        ExamResult(module: "PDSA 2", marks: 75),
        ExamResult(module: "TSLE", marks: 84),
        ExamResult(module: "Data Science", marks: 88),
        ExamResult(module: "Cyber Security", marks: 75),
        ExamResult(module: "DU", marks: 86),
        ExamResult(module: "ECS", marks: 87),
        ExamResult(module: "iOS", marks: nil),
        ExamResult(module: "Web API", marks: nil)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                headerSection
                
                resultsList
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Exam Results")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(false)
        }
    }
    
    private var headerSection: some View {
        HStack {
            Text("MODULE")
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.medium)
            
            Spacer()
            
            Text("MARKS")
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
    }
    
    private var resultsList: some View {
        VStack(spacing: 0) {
            ForEach(Array(examResults.enumerated()), id: \.offset) { index, result in
                ExamResultRow(result: result)
                
                if index < examResults.count - 1 {
                    Divider()
                        .padding(.leading, 16)
                }
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct ExamResultRow: View {
    let result: ExamResult
    
    var body: some View {
        HStack {
            Text(result.module)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            if let marks = result.marks {
                Text("\(marks)")
                    .font(.body)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
            } else {
                Text("-")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

struct ExamResult {
    let module: String
    let marks: Int?
}

struct ExamResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ExamResultsView()
    }
}
