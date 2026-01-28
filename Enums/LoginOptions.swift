//
//  LoginOptions.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

enum LoginOption {
    case signInWithApple(idToken: String, nonce: String)
    case signInWithGoogle
    case emailAndPassword(email: String, password: String)
}
