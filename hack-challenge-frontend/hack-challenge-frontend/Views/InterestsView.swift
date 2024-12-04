//
//  InterestsView.swift
//  hack-challenge-frontend
//
//  Created by Aaron Zhu on 12/3/24.
//

import SwiftUI

struct InterestsView: View {
    @State private var searchText = ""
    @State private var selectedInterests: Set<String> = []
    
    let interests = [
        "Design", "Business", "Art",
        "Music", "Sports",
        "Computer Science", "Chinese",
        "Employment", "Hiking", "Nature",
        "Culture", "Food", "Math",
        "Movies", "Concerts"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ONE LAST THING...")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("What are you interested in?")
                Text("What do you want to explore on campus?")
            }
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
            
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // Interests Grid
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 12)
            ], spacing: 12) {
                ForEach(interests.filter {
                    searchText.isEmpty ? true : $0.lowercased().contains(searchText.lowercased())
                }, id: \.self) { interest in
                    InterestButton(
                        title: interest,
                        isSelected: selectedInterests.contains(interest),
                        action: {
                            if selectedInterests.contains(interest) {
                                selectedInterests.remove(interest)
                            } else {
                                selectedInterests.insert(interest)
                            }
                        }
                    )
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                // TODO: navigate to ProfileView
            }) {
                NavigationLink(destination: ProfileView()) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            Button("Skip For Now") {
                // TODO: handle skip action
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .padding()
    }
}

struct InterestButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(isSelected ? Color.red : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(20)
        }
    }
}
