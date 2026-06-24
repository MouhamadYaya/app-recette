//
//  SupabaseManager.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import Foundation
import Supabase

// Configuration
// todo: Replace these with your Supabase project credentials
// Get these from: https://supabase.com/dashboard/project/YOUR_PROJECT/settings/api
private enum SupabaseConfig {
    static let url = "https://fvflmfvepwrqguumehoz.supabase.co"
    static let anonKey = "sb_publishable_XEYazoFZiwLy2uOQhKlv2Q_QgkwJLAo"
}

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        guard let url = URL(string: SupabaseConfig.url) else {
            fatalError("⚠️ URL Supabase invalide dans SupabaseManager.swift")
        }

        client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: SupabaseConfig.anonKey
        )
    }
}
