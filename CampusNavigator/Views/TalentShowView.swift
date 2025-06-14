//
//  TalentShowView.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-14.
//

import SwiftUI

struct TalentShowView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Title
                    Text("Talent Show")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)

                    // Event Image
                    Image("talentshow")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(12)
                    
                    // Subtitle
                    Text("Talent show 2025")
                        .font(.headline)
                    
                    Text("Get Ready to Dance!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    // Description
                    Text("""
Join us for the Annual University Dancing Competition, where rhythm meets passion! Watch talented performers light up the stage with their moves, from classical to hip-hop. Whether you're competing or cheering from the crowd, this is a night of energy, excitement, and unforgettable moments.
""")
                    
                    // Details
                    Text("""
Main Auditorium
Friday, June 14th
5:00 PM Onwards
""")
                    .font(.subheadline)

                    // Closing line
                    Text("Let the beat drop and the best dancers rise!")
                        .padding(.top)
                }
                .padding()
            }
            .navigationTitle("Talent Show")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TalentShowView()
}
