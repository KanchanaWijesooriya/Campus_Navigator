//
//  CrowdLevel.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-13.
//

import SwiftUI
import Charts

// MARK: - CrowdLevel Enum
enum CrowdLevel: String, Codable, CaseIterable, Identifiable {
    case happy = "Good to Go!"
    case neutral = ""
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

// MARK: - CampusArea Enum
enum CampusArea: String, CaseIterable, Identifiable {
    case cafeteria = "Cafeteria"
    case library = "Library"
    case gym = "Gym"

    var id: String { rawValue }
}

// MARK: - CrowdData Model
struct CrowdData: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let level: CrowdLevel
}

// MARK: - ViewModel
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

// MARK: - Main View
struct CrowdLevelsView: View {
    @StateObject private var viewModel = CrowdViewModel()
    @State private var showReportAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Area Picker
                Picker("Select Area", selection: $viewModel.selectedArea) {
                    ForEach(CampusArea.allCases) { area in
                        Text(area.rawValue).tag(area)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Current Crowd Level
                if let currentLevel = viewModel.currentCrowdLevel {
                    Text("Current Crowd Level: \(currentLevel.emoji) \(currentLevel.rawValue)")
                        .font(.title2)
                        .padding(.top)
                } else {
                    Text("No data for current level yet.")
                        .foregroundColor(.gray)
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
                .frame(height: 300)
                .padding()

                // Voting
                Text("Vote Crowd Level")
                    .font(.headline)

                HStack(spacing: 40) {
                    ForEach(CrowdLevel.allCases) { level in
                        Button(action: {
                            viewModel.vote(level: level)
                        }) {
                            Text(level.emoji)
                                .font(.system(size: 40))
                        }
                    }
                }
                .padding()

                // Report Button
                Button(action: {
                    showReportAlert = true
                }) {
                    Text("Report Fake Crowd Level")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                .alert("Report Submitted", isPresented: $showReportAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Thank you. Your report has been submitted.")
                }

                Spacer()
            }
            .navigationTitle("Crowd Levels")
        }
    }
}

// MARK: - Preview
struct CrowdLevelsView_Previews: PreviewProvider {
    static var previews: some View {
        CrowdLevelsView()
    }
}
