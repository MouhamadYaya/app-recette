//
//  Home.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import SwiftUI
import Supabase

struct Home: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSignOutConfirmation = false

    var body: some View {
        ZStack {
            // 🇺🇸 Background Gradient
            LinearGradient(
                colors: [.patriotGray, .patriotWhite],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {

                // Header
                VStack(spacing: 12) {
                    PatriotLogo()
                        .frame(width: 80, height: 80)

                    Text("Welcome, \(userName)")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.patriotBlue)
                }

                // MARK: - Information Card
                VStack(alignment: .leading, spacing: 16) {

                    UserInfoRow(
                        title: "Email",
                        value: authViewModel.currentUser?.email ?? "Unavailable"
                    )

                    UserInfoRow(
                        title: "Sign-In Method",
                        value: authViewModel.signInMethod
                    )

                    // Email verified indicator
                    if authViewModel.signInMethod == "Email / Password" {
                        let isVerified = authViewModel.currentUser?.emailConfirmedAt != nil

                        UserInfoRow(
                            title: "Email Verified",
                            value: isVerified ? "Yes" : "No",
                            valueColor: isVerified ? .green : .red
                        )
                    }

                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
                )
                .padding(.horizontal)

                Spacer()

                // sign Out Button
                Button {
                    showSignOutConfirmation = true
                } label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                        Text("Sign Out")
                    }
                    .patriotSecondaryButtonStyle()
                    .frame(width: 220)
                }
                .confirmationDialog(
                    "Are you sure you want to sign out?",
                    isPresented: $showSignOutConfirmation,
                    titleVisibility: .visible
                ) {
                    Button("Sign Out", role: .destructive) {
                        signOut()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                .padding(.bottom, 30)
            }
            .padding(.top, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }

    // display Name
    private var userName: String {
        guard let meta = authViewModel.currentUser?.userMetadata,
              let nameJSON = meta["display_name"],
              let encoded = try? JSONEncoder().encode(nameJSON),
              let name = try? JSONDecoder().decode(String.self, from: encoded),
              !name.isEmpty
        else { return "User" }
        return name
    }

    // sign Out Handler
    private func signOut() {
        Task {
            await authViewModel.signOut()
        }
    }
}


// MARK: - User Info Row

struct UserInfoRow: View {
    let title: String
    let value: String
    var valueColor: Color = .primary

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.medium)
                .foregroundColor(valueColor)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Home()
                .environmentObject(
                    AuthViewModel(authRepository: MockAuthRepository())
                )
        }
    }
}
