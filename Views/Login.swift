//
//  Login.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import SwiftUI

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showResetPasswordAlert: Bool = false
    @State private var resetPasswordEmail: String = ""
    @State private var showPasswordResetConfirmation: Bool = false
    
    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            // 🇺🇸 Background
            LinearGradient(
                colors: [.patriotGray, .patriotWhite],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // 🇺🇸 Logo
                PatriotLogo()
                    .frame(width: 80, height: 80)
                    .padding(.bottom, 20)
                
                Text("Login here!")
                    .foregroundColor(.patriotBlue)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 30)
                
                // form fields
                VStack(spacing: 16) {
                    TextField("Email Address", text: $email)
                        .patriotTextFieldStyle()
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .focused($emailIsFocused)
                        .onSubmit {
                            emailIsFocused = false
                            passwordIsFocused = true
                        }
                    
                    SecureField("Password", text: $password)
                        .patriotSecureFieldStyle()
                        .submitLabel(.go)
                        .focused($passwordIsFocused)
                        .onSubmit { signIn() }
                }
                .padding(.horizontal)
                
                // Forgot Password
                HStack {
                    Spacer()
                    Button("Forgot Password?") {
                        showResetPasswordAlert = true
                    }
                    .font(.footnote)
                    .foregroundColor(.patriotBlue)
                }
                .padding(.horizontal)
                .padding(.top, 6)
                
                // Error Message
                if let error = authViewModel.error {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 8)
                }
                
                // Sign In Button
                Button(action: signIn) {
                    if authViewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Sign In")
                    }
                }
                .patriotPrimaryButtonStyle()
                .padding(.horizontal)
                .padding(.top, 18)
                .disabled(email.isEmpty || password.isEmpty || authViewModel.isLoading)
                
                // Sign Up Button
                Button(action: signUp) {
                    Text("Create Account")
                }
                .patriotSecondaryButtonStyle()
                .padding(.horizontal)
                .padding(.top, 8)

                // Social Logins
                SocialLogins()
                    .padding(.top, 16)

                Spacer()
            }
            .alert("Reset Password", isPresented: $showResetPasswordAlert) {
                TextField("Enter your email", text: $resetPasswordEmail)
                    .keyboardType(.emailAddress)
                
                Button("Cancel", role: .cancel) {}
                
                Button("Reset") {
                    Task {
                        await authViewModel.sendPasswordReset(email: resetPasswordEmail)
                        showPasswordResetConfirmation = true
                    }
                }
            } message: {
                Text("Enter your email address and we'll send you a link to reset your password.")
            }
            .alert("Password Reset Email Sent", isPresented: $showPasswordResetConfirmation) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Check your email for a link to reset your password.")
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // Auth Helpers
    private func signIn() {
        Task {
            await authViewModel.login(with: .emailAndPassword(
                email: email,
                password: password
            ))
        }
    }
    
    private func signUp() {
        Task {
            try? await authViewModel.signUp(
                email: email,
                password: password
            )
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(AuthViewModel(
                authRepository: MockAuthRepository()
            ))
    }
}
