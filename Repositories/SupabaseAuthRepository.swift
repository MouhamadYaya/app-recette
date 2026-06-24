//
//  SupabaseAuthRepository.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import Foundation
import Supabase
import Auth

#if canImport(UIKit)
import UIKit
#endif

#if DEBUG
final class MockAuthRepository: AuthRepositoryProtocol {
    func signInWithEmail(email: String, password: String) async throws -> User { fatalError("preview only") }
    func signUpWithEmail(email: String, password: String) async throws -> User { fatalError("preview only") }
    func signOut() async throws {}
    func sendPasswordReset(email: String) async throws {}
    func getCurrentUser() async -> User? { nil }
    func updateUserProfile(displayName: String?, photoURL: URL?) async throws {}
    func updateEmail(email: String) async throws {}
    func updatePassword(password: String) async throws {}
    func signInWithApple(idToken: String, nonce: String) async throws -> User { fatalError("preview only") }
    func signInWithGoogle() async throws {}
}
#endif

protocol AuthRepositoryProtocol {
    func signInWithEmail(email: String, password: String) async throws -> User
    func signUpWithEmail(email: String, password: String) async throws -> User
    func signOut() async throws
    func sendPasswordReset(email: String) async throws
    func getCurrentUser() async -> User?
    func updateUserProfile(displayName: String?, photoURL: URL?) async throws
    func updateEmail(email: String) async throws
    func updatePassword(password: String) async throws
    func signInWithApple(idToken: String, nonce: String) async throws -> User
    func signInWithGoogle() async throws
}

final class SupabaseAuthRepository: AuthRepositoryProtocol {

    private let supabase = SupabaseManager.shared.client

    // Current User
    func getCurrentUser() async -> User? {
        do {
            let session = try await supabase.auth.session
            return session.user
        } catch {
            return nil
        }
    }

    // Sign In
    func signInWithEmail(email: String, password: String) async throws -> User {
        let result = try await supabase.auth.signIn(
            email: email,
            password: password
        )
        return result.user
    }

    // Sign Up
    func signUpWithEmail(email: String, password: String) async throws -> User {
        let result = try await supabase.auth.signUp(
            email: email,
            password: password
        )
        return result.user
    }

    // Sign Out
    func signOut() async throws {
        try await supabase.auth.signOut()
    }

    // Reset Password
    func sendPasswordReset(email: String) async throws {
        try await supabase.auth.resetPasswordForEmail(email)
    }

    // Update Metadata
    func updateUserProfile(displayName: String?, photoURL: URL?) async throws {
        var parts: [String: String] = [:]
        if let name = displayName { parts["display_name"] = name }
        if let url = photoURL { parts["photo_url"] = url.absoluteString }
        guard !parts.isEmpty else { return }

        let data = try JSONEncoder().encode(parts)
        let metadata = try JSONDecoder().decode([String: AnyJSON].self, from: data)
        try await supabase.auth.update(user: UserAttributes(data: metadata))
    }

    // Update Email
    func updateEmail(email: String) async throws {
        try await supabase.auth.update(user: UserAttributes(email: email))
    }

    // Update Password
    func updatePassword(password: String) async throws {
        try await supabase.auth.update(user: UserAttributes(password: password))
    }

    // Sign In With Apple
    func signInWithApple(idToken: String, nonce: String) async throws -> User {
        let session = try await supabase.auth.signInWithIdToken(
            credentials: .init(
                provider: .apple,
                idToken: idToken,
                nonce: nonce
            )
        )
        return session.user
    }

    // Sign In With Google
    func signInWithGoogle() async throws {
        let url = try await supabase.auth.getOAuthSignInURL(
            provider: Provider.google,
            redirectTo: URL(string: "swiftsupabasestarter://auth-callback")
        )

        #if canImport(UIKit)
        await MainActor.run {
            UIApplication.shared.open(url)
        }
        #endif
    }
}
