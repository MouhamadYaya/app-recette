//
//  SupabaseAuthRepository.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import Foundation
import Supabase
import Auth
internal import _Helpers

#if canImport(UIKit)
import UIKit
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
        var metadata: [String: AnyJSON] = [:]

        if let name = displayName {
            metadata["display_name"] = .string(name)
        }
        if let url = photoURL {
            metadata["photo_url"] = .string(url.absoluteString)
        }

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
