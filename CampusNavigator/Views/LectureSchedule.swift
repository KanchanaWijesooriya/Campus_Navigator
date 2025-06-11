//
//  LectureSchedule.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-11.
//

import SwiftUI

struct Lecture: Identifiable {
    let id = UUID()
    let name: String
    let hall: String
    let batch: String
    let time: String
    let lecturer: String
}

struct MyLectureScheduleView: View {
    @State private var searchText: String = ""

    let lectures = [
        Lecture(name: "Web API", hall: "Hall 18 - 2nd Floor", batch: "COBSCCOMP 24.1P", time: "09:00AM - 03:00PM", lecturer: "Mr. Niranga"),
        Lecture(name: "Mobile App Dev", hall: "Hall 05 - 1st Floor", batch: "COBSCCOMP 24.1P", time: "10:00AM - 12:00PM", lecturer: "Ms. Tharushi"),
        Lecture(name: "Database Systems", hall: "Hall 12 - Ground Floor", batch: "COBSCCOMP 24.1P", time: "01:00PM - 03:00PM", lecturer: "Mr. Senaka")
    ]

    var filteredLectures: [Lecture] {
        if searchText.isEmpty {
            return lectures
        } else {
            return lectures.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("My Lecture Schedule")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.top, .horizontal])

                TextField("Search lectures", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredLectures) { lecture in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(lecture.name)
                                    .font(.headline)
                                Text(lecture.hall)
                                    .font(.subheadline)
                                Text(lecture.batch)
                                    .font(.subheadline)
                                Text(lecture.time)
                                    .font(.subheadline)
                                Text(lecture.lecturer)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading) // Full width & left-aligned content
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(radius: 1)
                            .padding(.horizontal) // This defines the card's horizontal margins from the screen edge
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationBarHidden(true)
        }
    }
}


struct MyLectureScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyLectureScheduleView()
    }
}
