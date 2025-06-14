import SwiftUI

struct RepeatExamView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                
                // Title
                Text("Apply Repeat Exams")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                // Card Section
                VStack(spacing: 16) {
                    Text("Download the Re-sit form")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Button(action: {
                        // TODO: Add download action
                    }) {
                        Text("Download PDF")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RepeatExamView()
}
