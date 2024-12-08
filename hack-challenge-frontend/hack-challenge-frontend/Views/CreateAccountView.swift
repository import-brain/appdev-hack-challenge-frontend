import SwiftUI
import Foundation

// Referenced: https://peterfriese.dev/blog/2021/swiftui-concurrency-essentials-part1/
// Referenced: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-orders-over-the-internet
// Referenced: https://developer.apple.com/documentation/foundation/url_loading_system/uploading_data_to_a_website
struct CreateAccountView: View {
    @State private var displayName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var profileImage: UIImage?
    @State private var showImagePicker = false
    @State private var navigateToInterests = false
    
    func createUser() async {
        let user = UserModel(displayName: displayName, email: email, password: password)
        guard let encodedUser = try? JSONEncoder().encode(user) else {
            print("Encountered an error encoding the user")
            return
        }
        let endpoint = URL(string: "http://parsa.hackchallenge.bucket.s3.us-east-1.amazonaws.com/register/")!
        var req = URLRequest(url: endpoint)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: req, from: encodedUser)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
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
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                TextField("Enter password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Text("These will be shown on any posters\nyou upload")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                NavigationLink(destination: InterestsView()) {
                    Text("Create Account")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .onAppear {
                            Task {
                                await createUser()
                            }
                        }
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profileImage)
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
