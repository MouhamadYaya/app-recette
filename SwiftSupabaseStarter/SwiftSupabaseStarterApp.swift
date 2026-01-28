//
//  SwiftSupabaseStarterApp.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import SwiftUI
import Supabase

@main
struct SwiftSupabaseStarterApp: App {

    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .onOpenURL { url in
                    handleOAuthCallback(url: url)
                }
        }
    }

    // Handles OAuth redirect callbacks from social login providers
    private func handleOAuthCallback(url: URL) {
        Task {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
                return
            }

            do {
                try await SupabaseManager.shared.client.auth.exchangeCodeForSession(authCode: code)
                await authViewModel.checkAuthenticationState()
            } catch {
                authViewModel.error = .signInFailed(description: error.localizedDescription)
            }
        }
    }
}
