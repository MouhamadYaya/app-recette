//
//  AuthError.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import Foundation

enum AuthError: LocalizedError {
    case signInFailed(description: String)
    case signUpFailed(description: String)
    case signOutFailed(description: String)
    case userNotFound
    case invalidCredential
    case emailNotVerified
    case passwordResetFailed(description: String)
    case updateProfileFailed(description: String)
    case deleteAccountFailed(description: String)
    case updateEmailFailed(description: String)
    case updatePasswordFailed(description: String)

    var errorDescription: String? {
        switch self {
        case .signInFailed(let description):
            return "Sign in failed: \(description)"
        case .signUpFailed(let description):
            return "Sign up failed: \(description)"
        case .signOutFailed(let description):
            return "Sign out failed: \(description)"
        case .userNotFound:
            return "User not found"
        case .invalidCredential:
            return "Invalid credentials"
        case .emailNotVerified:
            return "Email not verified"
        case .passwordResetFailed(let description):
            return "Password reset failed: \(description)"
        case .updateProfileFailed(let description):
            return "Failed to update profile: \(description)"
        case .deleteAccountFailed(let description):
            return "Failed to delete account: \(description)"
        case .updateEmailFailed(let description):
            return "Failed to update email: \(description)"
        case .updatePasswordFailed(let description):
            return "Failed to update password: \(description)"
        }
    }
}
