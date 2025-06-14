//
//  NewsFeedView.swift
//  CampusNavigator
//
//  Created by Chanuka Wijesooriya  on 2025-06-14.
//

//
//  NewsFeedView.swift
//  CampusNavigator
//
//  Created by Thimanjila Udangawe on 2025-06-13.
//

import SwiftUI

// Constants for the News Feed
private struct NewsConstants {
    static let SystemLabelPrimary: Color = .black
    static let TileOffWhiteColor: Color = Color(red: 0.98, green: 0.98, blue: 0.98)
    static let newTextGray: Color = Color(red: 0.5, green: 0.51, blue: 0.57)
}

struct NewsFeedView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
//                    HStack {
//                        Button(action: {
//                            // Back action
//                        }) {
//                            HStack(spacing: 4) {
//                                Image(systemName: "chevron.left")
//                                    .font(.system(size: 16, weight: .medium))
//                                    .foregroundColor(.blue)
//                                Text("Back")
//                                    .font(.system(size: 17))
//                                    .foregroundColor(.blue)
//                            }
//                        }
//                        Spacer()
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.top, 8)
                    
                    // Title
                    HStack {
                        Text("News Feed")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(NewsConstants.SystemLabelPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    
                    // News Cards in Staggered Layout
                    LazyVStack(spacing: 16) {
                        HStack(alignment: .top, spacing: 12) {
                            // Left Column
                            VStack(spacing: 16) {
                                // Graduation Ceremony Card
                                NewsCard(
                                    imageName: "graduation_ceremony_image", // You'll add this to Assets
                                    title: "Graduation Ceremony",
                                    subtitle: "2025 Graduation Ceremony ...",
                                    imageHeight: 118,
                                    cardWidth: 175
                                )
                                
                                // After O/L's Foundation Card
                                NewsCard(
                                    imageName: "foundation_course_image", // You'll add this to Assets
                                    title: "After O/L's Foundation",
                                    subtitle: "Start foundation after your o/l ...",
                                    imageHeight: 118,
                                    cardWidth: 175
                                )
                                // After O/L's Foundation Card
                                NewsCard(
                                    imageName: "foundation_course_image", // You'll add this to Assets
                                    title: "After O/L's Foundation",
                                    subtitle: "Start foundation after your o/l ...",
                                    imageHeight: 118,
                                    cardWidth: 175
                                )
                            }
                            
                            
                            // Right Column
                            VStack(spacing: 16) {
                                // Start After Your A/L's Card
                                NewsCard(
                                    imageName: "al_course_image", // You'll add this to Assets
                                    title: "Start After Your A/L's",
                                    subtitle: "Discount for your 3As result ...",
                                    imageHeight: 118,
                                    cardWidth: 175
                                )
                                
                                // Talent Show 2025 Card
                                NavigationLink(destination: TalentShowView()){
                                    NewsCard(
                                        imageName: "talent_show_image", // You'll add this to Assets
                                        title: "Talent Show 2025",
                                        subtitle: "Talent Show 2025 News and updates ...",
                                        imageHeight: 118,
                                        cardWidth: 175
                                    )
                                }
                                
                                // Talent Show 2025 Card
                                NavigationLink(destination: TalentShowView()){
                                    NewsCard(
                                        imageName: "talent_show_image", // You'll add this to Assets
                                        title: "Talent Show 2025",
                                        subtitle: "Talent Show 2025 News and updates ...",
                                        imageHeight: 118,
                                        cardWidth: 175
                                    )
                                }
                            }
                            
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }
}

struct NewsCard: View {
    let imageName: String
    let title: String
    let subtitle: String
    let imageHeight: CGFloat
    let cardWidth: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            // Image container
            ZStack {
                Rectangle()
                    .fill(NewsConstants.TileOffWhiteColor)
                    .frame(width: cardWidth, height: imageHeight)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardWidth, height: imageHeight)
                    .clipped()
            }
            .cornerRadius(10, corners: [.topLeft, .topRight])
            
            // Text container
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(NewsConstants.newTextGray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
        }
        .frame(width: cardWidth)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
    }
}

// Extension for UIRectCorner compatibility
struct Corner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Preview
struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
