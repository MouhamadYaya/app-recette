# SwiftUI + Supabase Starter

A clean, production-ready starter template for building modern iOS apps using **SwiftUI**, **MVVM**, and **Supabase** for authentication and backend services.  
This template is designed to help you skip boilerplate setup and jump straight into building your app.

---

Features

Authentication
- Email/password login & signup
- Session persistence
- Automatic session restoration
- AuthViewModel with async/await support
- Ready-to-use AuthRepository abstraction

Supabase Integration
- `SupabaseManager` singleton
- Proper async auth flows
- URL handling for deep links (magic links, OAuth, etc.)
- Designed for Supabase Swift SDK 2.x

SwiftUI Templates
- Login screen
- Home screen placeholder
- Environment object setup
- Scene handling via `@main`

Easily Extendable
You can add:
- Realtime subscriptions  
- Row-level security logic  
- User profile tables  
- Admin dashboards  
- Secure storage  
- Push notifications  
- And more

Requirements

- macOS Sonoma or later
- Xcode 15+
- iOS 17+
- Swift 5.9+
- A Supabase project and anon key

---

Setup Instructions

1. Clone the repository:
   git clone https://github.com/colelucky45/swift-supabase-starter.git

2. Open the project:
   swift_app.xcodeproj

3. Add the Supabase Swift SDK
    Go to Xcode → File → Add Packages…
    Enter this URL:
    https://github.com/supabase/supabase-swift
    Set Dependency Rule to:
    Exact Version
    2.5.1
    Click Add Package
   
4. Add your Supabase project values
    Open SupabaseManager.swift and replace the placeholders:
    static let supabaseURL = URL(string: "your URL here")!
    static let supabaseKey = "Your API key here"

5. Build the project
    Use ⌘ + B to build.
    After the build succeeds, run the app on a simulator or device.
