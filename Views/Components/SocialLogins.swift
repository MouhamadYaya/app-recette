//
//  SocialLogins.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import SwiftUI
import AuthenticationServices

struct SocialLogins: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 12) {
            // Divider with "or"
            HStack {
                Rectangle()
                    .fill(Color.patriotBlue.opacity(0.3))
                    .frame(height: 1)
                Text("or")
                    .font(.footnote)
                    .foregroundColor(.patriotBlue.opacity(0.6))
                Rectangle()
                    .fill(Color.patriotBlue.opacity(0.3))
                    .frame(height: 1)
            }
            .padding(.vertical, 8)

            // Google Sign In
            Button {
                Task { await signInWithGoogle() }
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "g.circle.fill")
                        .font(.title2)
                    Text("Continue with Google")
                        .font(.headline)
                }
                .foregroundColor(.patriotBlue)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.patriotBlue, lineWidth: 1.5)
                )
            }

            // Apple Sign In
            SignInWithAppleButton(.continue) { request in
                let nonce = String.randomNonceString()
                authViewModel.currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = nonce.sha256
            } onCompletion: { result in
                Task { await handleAppleSignIn(result: result) }
            }
            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .frame(height: 50)
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }

    // Google Sign In
    private func signInWithGoogle() async {
        await authViewModel.login(with: .signInWithGoogle)
    }

    // MARK: - Apple Sign In Handler
    private func handleAppleSignIn(result: Result<ASAuthorization, Error>) async {
        switch result {
        case .success(let authorization):
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
                  let identityToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: identityToken, encoding: .utf8),
                  let nonce = authViewModel.currentNonce else {
                authViewModel.error = .signInFailed(description: "Failed to get Apple ID credentials")
                return
            }

            await authViewModel.login(with: .signInWithApple(idToken: idTokenString, nonce: nonce))

        case .failure(let error):
            // User cancelled is not an error we need to show
            if (error as NSError).code != ASAuthorizationError.canceled.rawValue {
                authViewModel.error = .signInFailed(description: error.localizedDescription)
            }
        }
    }
}

struct SocialLogins_Previews: PreviewProvider {
    static var previews: some View {
        SocialLogins()
            .environmentObject(AuthViewModel())
    }
}
