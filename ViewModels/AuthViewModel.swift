//
//  AuthViewModel.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import SwiftUI
import Supabase
import Combine

@MainActor
class AuthViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var state: SignInState = .signedOut
    @Published var error: AuthError?
    @Published var isLoading: Bool = false
    @Published var signInMethod: String = "Email / Password"
    @Published var currentUser: User?

    // MARK: - Apple Sign In State
    var currentNonce: String?

    // MARK: - Dependencies
    private let authRepository: AuthRepositoryProtocol

    // MARK: - Init
    init(authRepository: AuthRepositoryProtocol = SupabaseAuthRepository()) {
        self.authRepository = authRepository
        Task {
            await checkAuthenticationState()
        }
    }

    // Check Existing Session
    func checkAuthenticationState() async {
        let user = await authRepository.getCurrentUser()
        self.currentUser = user
        self.state = user != nil ? .signedIn : .signedOut
    }

    // MARK: - Login Router
    func login(with loginOption: LoginOption) async {
        isLoading = true
        error = nil

        defer { isLoading = false }

        do {
            switch loginOption {
            case let .emailAndPassword(email, password):
                try await signInWithEmail(email: email, password: password)
                signInMethod = "Email / Password"

            case .signInWithGoogle:
                try await signInWithGoogle()
                signInMethod = "Google"

            case let .signInWithApple(idToken, nonce):
                try await signInWithApple(idToken: idToken, nonce: nonce)
                signInMethod = "Apple"
            }

        } catch let authError as AuthError {
            self.error = authError
        } catch {
            self.error = .signInFailed(description: error.localizedDescription)
        }
    }

    // Sign In Handlers
    func signInWithEmail(email: String, password: String) async throws {
        self.currentUser = try await authRepository.signInWithEmail(email: email, password: password)
        self.state = .signedIn
    }

    func signUp(email: String, password: String) async throws {
        self.currentUser = try await authRepository.signUpWithEmail(email: email, password: password)
        self.state = .signedIn
    }

    // MARK: - Social Sign In
    func signInWithApple(idToken: String, nonce: String) async throws {
        self.currentUser = try await authRepository.signInWithApple(idToken: idToken, nonce: nonce)
        self.state = .signedIn
    }

    func signInWithGoogle() async throws {
        try await authRepository.signInWithGoogle()
        // Note: Google OAuth redirects to browser, session is handled via URL callback
    }

    // Sign Out
    func signOut() async {
        isLoading = true
        error = nil

        do {
            try await authRepository.signOut()
            state = .signedOut
            currentUser = nil
            signInMethod = "Email / Password"
        } catch {
            self.error = error as? AuthError ?? .signOutFailed(description: error.localizedDescription)
        }

        isLoading = false
    }

    // User Profile Actions
    func sendPasswordReset(email: String) async {
        isLoading = true
        error = nil

        do {
            try await authRepository.sendPasswordReset(email: email)
        } catch {
            self.error = .passwordResetFailed(description: error.localizedDescription)
        }

        isLoading = false
    }

    func updateProfile(displayName: String?, photoURL: URL?) async {
        isLoading = true
        error = nil

        do {
            try await authRepository.updateUserProfile(displayName: displayName, photoURL: photoURL)
            self.currentUser = await authRepository.getCurrentUser()
        } catch {
            self.error = .updateProfileFailed(description: error.localizedDescription)
        }

        isLoading = false
    }

    func updateEmail(email: String) async {
        isLoading = true
        error = nil

        do {
            try await authRepository.updateEmail(email: email)
            self.currentUser = await authRepository.getCurrentUser()
        } catch {
            self.error = .updateEmailFailed(description: error.localizedDescription)
        }

        isLoading = false
    }

    func updatePassword(password: String) async {
        isLoading = true
        error = nil

        do {
            try await authRepository.updatePassword(password: password)
        } catch {
            self.error = .updatePasswordFailed(description: error.localizedDescription)
        }

        isLoading = false
    }
}
