import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // Rapido Yellow
    let brandYellow = Color.brand
    
    var body: some View {
        ZStack {
            // Background
            brandYellow.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Logo & Title
                VStack(spacing: 10) {
                    Image(systemName: "bicycle")
                        .font(.system(size: 70))
                        .foregroundColor(.black)
                    
                    Text("SmartCommute")
                        .font(.system(size: 34, weight: .black))
                        .foregroundColor(.black)
                        .tracking(-0.5)
                }
                .padding(.top, 80)
                
                Spacer()
                
                // Login Card
                VStack(spacing: 20) {
                    Text("Login to continue")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    
                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Email Field
                    TextField("Email", text: $authViewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    
                    // Password Field
                    SecureField("Password", text: $authViewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    
                    // Login Button (Black)
                    Button(action: {
                        authViewModel.login()
                    }) {
                        HStack {
                            if authViewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: brandYellow))
                            } else {
                                Text("Continue")
                                    .fontWeight(.bold)
                            }
                        }
                        .foregroundColor(brandYellow)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                    .disabled(authViewModel.isLoading)
                    
                    HStack {
                        VStack { Divider() }
                        Text("OR")
                            .font(.caption)
                            .foregroundColor(.gray)
                        VStack { Divider() }
                    }
                    .padding(.vertical, 5)
                    
                    // Social Logins
                    HStack(spacing: 15) {
                        SocialLoginButton(iconName: "g.circle.fill", title: "Google")
                        SocialLoginButton(iconName: "applelogo", title: "Apple")
                    }
                }
                .padding(30)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: -5)
                .padding(.bottom, 0)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
