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
    case happy = "Happy"
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

// MARK: - Area Enum
enum CampusArea: String, CaseIterable, Identifiable {
    case cafeteria = "Cafeteria"
    case library = "Library"
    case gym = "Gym"

    var id: String { rawValue }
}

// MARK: - Crowd Data
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
        let today = Calendar.current.startOfDay(for: Date())
        votes[selectedArea, default: []].append(CrowdData(date: today, level: level))
    }

    func dataForLast7Days() -> [Date: [CrowdLevel: Int]] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let last7Days = (0..<7).map { calendar.date(byAdding: .day, value: -$0, to: today)! }

        var result: [Date: [CrowdLevel: Int]] = [:]
        for date in last7Days {
            let dayVotes = votes[selectedArea, default: []].filter {
                calendar.isDate($0.date, inSameDayAs: date)
            }
            var levelCount: [CrowdLevel: Int] = [:]
            for level in CrowdLevel.allCases {
                levelCount[level] = dayVotes.filter { $0.level == level }.count
            }
            result[date] = levelCount
        }
        return result
    }

    private func generateRandomData() -> [CrowdData] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).flatMap { offset -> [CrowdData] in
            let date = calendar.date(byAdding: .day, value: -offset, to: today)!
            return (0..<Int.random(in: 5...15)).map { _ in
                CrowdData(date: date, level: CrowdLevel.allCases.randomElement()!)
            }
        }
    }
}

// MARK: - Main View
struct CrowdLevelsView: View {
    @StateObject private var viewModel = CrowdViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Picker("Select Area", selection: $viewModel.selectedArea) {
                    ForEach(CampusArea.allCases) { area in
                        Text(area.rawValue).tag(area)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Chart {
                    ForEach(viewModel.dataForLast7Days().sorted(by: { $0.key < $1.key }), id: \ .key) { date, levelCounts in
                        ForEach(CrowdLevel.allCases) { level in
                            BarMark(
                                x: .value("Day", date, unit: .day),
                                y: .value("Votes", levelCounts[level] ?? 0),
                                stacking: .normalized
                            )
                            .foregroundStyle(by: .value("Level", level.rawValue))
                        }
                    }
                }
                .frame(height: 300)
                .padding()

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
