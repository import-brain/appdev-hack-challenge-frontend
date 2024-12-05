// CreateAccountView.swift
import SwiftUI

struct CreateAccountView: View {
    @State private var displayName = ""
    @State private var profileImage: UIImage?
    @State private var showImagePicker = false
    @State private var navigateToInterests = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Welcome")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Please tell us a\nlittle about yourself")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                Button(action: {
                    showImagePicker = true
                }) {
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40))
                            )
                    }
                }
                
                Button("Upload Avatar") {
                    showImagePicker = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                TextField("Enter display name", text: $displayName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Text("These will be shown on any posters\nyou upload")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                NavigationLink(destination: InterestsView()) {
                    Text("Create Account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profileImage)
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
