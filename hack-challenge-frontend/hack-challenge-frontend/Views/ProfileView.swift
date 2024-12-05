import SwiftUI

struct ProfileView: View {
    @State private var selectedTab = 0 // 0 for Saved, 1 for My Posts
    @State private var posters: [PosterModel] = []
    
    var upcomingPosters: [PosterModel] {
        posters.filter { $0.isUpcoming }
    }
    
    var pastPosters: [PosterModel] {
        posters.filter { !$0.isUpcoming }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Text("PROFILE")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: handle upload
                    }) {
                        Text("Upload")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 0) {
                    Button(action: { selectedTab = 0 }) {
                        Text("Saved")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedTab == 0 ? Color.white : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTab == 0 ? .black : .gray)
                    }
                    
                    Button(action: { selectedTab = 1 }) {
                        Text("My Posts")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedTab == 1 ? Color.white : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTab == 1 ? .black : .gray)
                    }
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Upcoming")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(upcomingPosters) { poster in
                                    EventCard(poster: poster)
                                }
                                if upcomingPosters.isEmpty {
                                    EventCard(poster: nil)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Past")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(pastPosters) { poster in
                                    EventCard(poster: poster)
                                }
                                if pastPosters.isEmpty {
                                    EventCard(poster: nil)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                NavigationLink(destination: CreatePosterView(posters: $posters)) {
                    Text("Create Post")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}

struct EventCard: View {
    let poster: PosterModel?
    
    var body: some View {
        if let poster = poster {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 150, height: 200)
                .overlay(
                    VStack(alignment: .leading, spacing: 8) {
                        Text(poster.title)
                            .font(.headline)
                        Text(poster.location)
                            .font(.subheadline)
                        Text(formatDate(poster.date))
                            .font(.caption)
                        Spacer()
                        HStack {
                            ForEach(poster.tags.prefix(3), id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                )
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 150, height: 200)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    // Referenced: https://ios-course.cornellappdev.com/chapters/swiftui/getting-started-with-swiftui
    ProfileView()
}
