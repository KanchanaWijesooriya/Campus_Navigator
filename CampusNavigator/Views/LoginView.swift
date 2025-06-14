
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer(minLength: geometry.size.height * 0.08)

                    // ✅ Custom Title Heading
                    Text("Campus Navigator")
                        .font(.system(size: 36, weight: .bold))
                        .padding(.top, 2)
                        .padding(.bottom, 30)

                    // Logo
                    Image("CNimage2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .padding(.bottom, 50)

                    // Form
                    VStack(spacing: 20) {
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
                    .frame(maxWidth: 400)

                    // Login Button
                    NavigationLink(destination: MainTabView()
                        .navigationBarBackButtonHidden(true)) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 400)
                    .padding(.top, 16)

                    // Forgot Password
                    Button("Forgot Password?") {
                        // Action here
                    }
                    .foregroundColor(.blue)
                    .padding(.top, 12)

                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .navigationBarHidden(true) // Hide default nav bar title
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 16 Pro Max")
    }
}


