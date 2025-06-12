import SwiftUI

struct ExamResultsView: View {
    let results: [ModuleResult] = [
        .init(name: "PDSA 2", marks: "75"),
        .init(name: "TSLE", marks: "84"),
        .init(name: "Data Science", marks: "88"),
        .init(name: "Cyber Security", marks: "75"),
        .init(name: "DU", marks: "86"),
        .init(name: "ECS", marks: "87"),
        .init(name: "iOS", marks: "-"),
        .init(name: "Web API", marks: "-")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // MARK: Header Section
                HStack {
                    Button(action: {
                        // Action to go back
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                            .padding()
                    }
                    Spacer()
                    Text("Exam Results")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Spacer().frame(width: 44) // Placeholder for alignment
                }
                .padding(.top, 16)
                
                // MARK: Results List
                VStack(spacing: 10) {
                    ForEach(results, id: \.name) { result in
                        ResultRow(result: result)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 7)
                .background(Constants.BackgroundsGroupedSecondary)
                .cornerRadius(10)
                .frame(width: 370)
                
                Spacer()
                
                // MARK: Footer Navigation
                HStack {
                    Spacer()
                    FooterItem(title: "Map My Events")
                    Spacer()
                    FooterItem(title: "Home")
                    Spacer()
                    FooterItem(title: "Crowd Levels")
                    Spacer()
                    FooterItem(title: "Foods")
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
            }
            .navigationTitle("") // Remove large title
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: Constants
struct Constants {
    static let BackgroundsGroupedSecondary: Color = .white
}

// MARK: Data Model
struct ModuleResult {
    let name: String
    let marks: String
}

// MARK: Row View
struct ResultRow: View {
    let result: ModuleResult
    
    var body: some View {
        HStack {
            Text(result.name)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(result.marks)
                .frame(alignment: .trailing)
        }
        .padding(.horizontal, 0)
        .frame(maxWidth: .infinity)
    }
}

// MARK: Footer Item
struct FooterItem: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.blue)
    }
}

// MARK: Preview
struct ExamResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ExamResultsView()
    }
}
