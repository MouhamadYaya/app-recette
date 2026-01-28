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
    static let url = "https://your-project-id.supabase.co"
    static let anonKey = "your-anon-key-here"
}

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        guard let url = URL(string: SupabaseConfig.url),
              SupabaseConfig.url != "https://your-project-id.supabase.co" else {
            fatalError("""
                ⚠️ Supabase not configured!

                Please update SupabaseConfig in SupabaseManager.swift with your project credentials.
                Get these from: https://supabase.com/dashboard/project/YOUR_PROJECT/settings/api
                """)
        }

        client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: SupabaseConfig.anonKey
        )
    }
}
