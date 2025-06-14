import SwiftUI

struct ModuleResult: Identifiable {
    let id = UUID()
    let moduleName: String
    let marks: Int
}

struct ExamResultsView: View {
    let results = [
        ModuleResult(moduleName: "Web API", marks: 85),
        ModuleResult(moduleName: "Mobile App Development", marks: 90),
        ModuleResult(moduleName: "Database Systems", marks: 78),
        ModuleResult(moduleName: "Software Engineering", marks: 88),
        ModuleResult(moduleName: "Cyber Security", marks: 67)
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Exam Results")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                // Table header
                HStack {
                    Text("Module")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Marks")
                        .font(.headline)
                        .frame(width: 80, alignment: .trailing)
                }
                .padding(.horizontal)

                // Table rows
                List {
                    ForEach(results) { result in
                        HStack {
                            Text(result.moduleName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(result.marks)%")
                                .frame(width: 80, alignment: .trailing)
                                .foregroundColor(result.marks >= 50 ? .green : .red)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationBarHidden(true)
        }
    }
}

struct ExamResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ExamResultsView()
    }
}
