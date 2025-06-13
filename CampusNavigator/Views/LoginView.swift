//import SwiftUI
//
//struct LoginView: View {
//    @State private var email = ""
//    @State private var password = ""
//    @Binding var isLoggedIn = Bool
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 32) {
//                // Header
//                Image("LoginLogo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 120, height: 120)
//                    .padding(.top, 64)
//                
//                // Form
//                VStack(spacing: 24) {
//                    TextField("Email", text: $email)
//                        .autocapitalization(.none)
//                        .keyboardType(.emailAddress)
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                    
//                    SecureField("Password", text: $password)
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
//                
//                // Login Button
//                Button(action: {
//                    isLoggedIn = true
//                          
//                }) {
//                    Text("Log In")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
//                
//                // Forgot Password
//                Button("Forgot Password?") {
//                    // Placeholder action
//                }
//                .foregroundColor(.blue)
//                .padding(.top, 8)
//                
//                Spacer()
//            }
//            .navigationTitle("Campus Navigator")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var isLoggedIn: Bool  // ✅ Correct binding syntax
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                // Header
                Image("LoginLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 64)
                
                // Form
                VStack(spacing: 24) {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Login Button
                Button(action: {
                    isLoggedIn = true // ✅ triggers switch to MainTabView
                }) {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Forgot Password
                Button("Forgot Password?") {
                    // Placeholder action
                }
                .foregroundColor(.blue)
                .padding(.top, 8)
                
                Spacer()
            }
            .navigationTitle("Campus Navigator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
