//
//  CreatePosterView.swift
//  hack-challenge-frontend
//
//  Created by Aaron Zhu on 12/3/24.
//

import SwiftUI

struct CreatePosterView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var posters: [PosterModel]
    @State private var title = ""
    @State private var date = Date()
    @State private var location = ""
    @State private var description = ""
    @State private var selectedTags: Set<String> = []
    
    let tags = ["Design", "Business", "Art", "Music", "Sports", "Computer Science",
                "Chinese", "Employment", "Hiking", "Nature", "Culture", "Food",
                "Math", "Movies", "Concerts"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    )
                
                VStack(alignment: .leading, spacing: 16) {
                    TextField("Event Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.title2)
                    
                    HStack {
                        Image(systemName: "calendar")
                        DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    }
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        TextField("Location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Text("ABOUT")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2))
                        )
                    
                    Text("TAGS")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(tags, id: \.self) { tag in
                                TagButton(
                                    title: tag,
                                    isSelected: selectedTags.contains(tag),
                                    action: {
                                        if selectedTags.contains(tag) {
                                            selectedTags.remove(tag)
                                        } else {
                                            selectedTags.insert(tag)
                                        }
                                    }
                                )
                            }
                            Button("+ Add") {
                                // TODO: custom tag
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding()
                Spacer()
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    Button("Post") {
                        savePost()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Edit/Create Poster")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func savePost() {
        let poster = PosterModel(
            id: UUID(),
            title: title,
            date: date,
            location: location,
            description: description,
            tags: Array(selectedTags)
        )
        posters.append(poster)
        // TODO: add to local storage or state management
    }
}

struct TagButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.red : Color.gray.opacity(0.1))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(15)
        }
    }
}
