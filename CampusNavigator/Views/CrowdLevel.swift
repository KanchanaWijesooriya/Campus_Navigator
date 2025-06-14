//
//  CrowdLevel.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-13.
//

import SwiftUI
import Charts


enum CrowdLevel: String, Codable, CaseIterable, Identifiable {
    case happy = "Good to Go!"
    case neutral = "Neutral"
    case sad = "Sad"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .happy: return "😄"
        case .neutral: return "😐"
        case .sad: return "🙁"
        }
    }
}


enum CampusArea: String, CaseIterable, Identifiable {
    case cafeteria = "Cafeteria"
    case library = "Library"
    case gym = "Gym"

    var id: String { rawValue }
}


struct CrowdData: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let level: CrowdLevel
}


class CrowdViewModel: ObservableObject {
    @Published var selectedArea: CampusArea = .cafeteria
    @Published var votes: [CampusArea: [CrowdData]] = [:]

    init() {
        for area in CampusArea.allCases {
            votes[area] = generateRandomData()
        }
    }

    func vote(level: CrowdLevel) {
        let now = Date()
        votes[selectedArea, default: []].append(CrowdData(date: now, level: level))
    }

    func hourlyDataForToday() -> [Int: [CrowdLevel: Int]] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let todayVotes = votes[selectedArea, default: []].filter {
            calendar.isDate($0.date, inSameDayAs: today)
        }

        var hourlyData: [Int: [CrowdLevel: Int]] = [:]

        for hour in 0..<24 {
            let hourVotes = todayVotes.filter {
                calendar.component(.hour, from: $0.date) == hour
            }

            var levelCount: [CrowdLevel: Int] = [:]
            for level in CrowdLevel.allCases {
                levelCount[level] = hourVotes.filter { $0.level == level }.count
            }
            hourlyData[hour] = levelCount
        }

        return hourlyData
    }

    var currentCrowdLevel: CrowdLevel? {
        let now = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: now)

        let hourVotes = votes[selectedArea, default: []].filter {
            calendar.isDate($0.date, inSameDayAs: now) &&
            calendar.component(.hour, from: $0.date) == currentHour
        }

        let levelCount = Dictionary(grouping: hourVotes, by: { $0.level })
            .mapValues { $0.count }

        return levelCount.max(by: { $0.value < $1.value })?.key
    }

    private func generateRandomData() -> [CrowdData] {
        let calendar = Calendar.current
        let now = Date()
        return (0..<7).flatMap { dayOffset -> [CrowdData] in
            let date = calendar.date(byAdding: .day, value: -dayOffset, to: now)!
            return (0..<Int.random(in: 10...20)).map { _ in
                let randomHour = Int.random(in: 0..<24)
                let randomDate = calendar.date(bySettingHour: randomHour, minute: 0, second: 0, of: date)!
                return CrowdData(date: randomDate, level: CrowdLevel.allCases.randomElement()!)
            }
        }
    }
}


struct CrowdLevelsView: View {
    @StateObject private var viewModel = CrowdViewModel()
    @State private var showReportAlert = false
    @State private var showCreditsAlert = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    // Title
                    Text("Crowd Levels")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                        
                    // Area Picker
                    Picker("Select Area", selection: $viewModel.selectedArea) {
                        ForEach(CampusArea.allCases) { area in
                            Text(area.rawValue).tag(area)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    // Boxed Current Crowd Level
                    if let currentLevel = viewModel.currentCrowdLevel {
                        VStack(spacing: 8) {
                            Text("Current Crowd Level")
                                .font(.headline)

                            Text("\(currentLevel.emoji) \(currentLevel.rawValue)")
                                .font(.system(size: 28, weight: .semibold))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    } else {
                        Text("No data for current level yet.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }

                    // Chart View
                    Chart {
                        ForEach(viewModel.hourlyDataForToday().sorted(by: { $0.key < $1.key }), id: \.key) { hour, levelCounts in
                            ForEach(CrowdLevel.allCases) { level in
                                BarMark(
                                    x: .value("Hour", "\(hour):00"),
                                    y: .value("Votes", levelCounts[level] ?? 0)
                                )
                                .foregroundStyle(by: .value("Level", level.rawValue))
                            }
                        }
                    }
                    .frame(width: 300, height: 240)
                    .padding(.horizontal)

                    // Voting Title
                    Text("Vote Crowd Level")
                        .font(.headline)
                        .padding(.top)

                    // Voting Emoji Buttons
                    HStack(spacing: 40) {
                        ForEach(CrowdLevel.allCases) { level in
                            Button(action: {
                                viewModel.vote(level: level)
                            }) {
                                Text(level.emoji)
                                    .font(.system(size: 48))
                                    .padding(10)
                            }
                        }
                    }

                    // How to Earn Credits Button
                    Button(action: {
                        showCreditsAlert = true
                    }) {
                        Text("How to earn more credits?")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .padding(.top, 12)
                    }
                    .alert("How To Earn Credits?", isPresented: $showCreditsAlert) {
                        Button("Got it", role: .cancel) { }
                    } message: {
                        Text("""
Update the current crowd level to help others.
Each interaction earns you credits, which can be redeemed for rewards in the rewards section.

Note: The system actively detects false or unusual activity. Providing inaccurate information may lead to credit loss or a permanent ban from participation.
""")
                    }

                    // Report Fake Button
                    Button(action: {
                        showReportAlert = true
                    }) {
                        Text("Report Fake Crowd Level")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding(.top, 8)
                    }
                    .alert("Report Submitted", isPresented: $showReportAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Thank you. Your report has been submitted.")
                    }

                    Spacer(minLength: 32)
                }
            }
        }
    }
}


struct CrowdLevelsView_Previews: PreviewProvider {
    static var previews: some View {
        CrowdLevelsView()
    }
}
