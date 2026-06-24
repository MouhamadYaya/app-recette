//
//  ContentView.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/19/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            Group {
                if authViewModel.state == .signedIn {
                    Home()
                } else {
                    Login()
                }
            }
            .animation(.easeInOut, value: authViewModel.state)
        }
        .overlay {
            if authViewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: errorBinding) { identifiableError in
            Alert(
                title: Text("Error"),
                message: Text(identifiableError.errorDescription),
                dismissButton: .default(Text("OK")) {
                    authViewModel.error = nil
                }
            )
        }
    }

    // Convert AuthError into IdentifiableError for alerts
    private var errorBinding: Binding<IdentifiableError?> {
        Binding<IdentifiableError?>(
            get: {
                guard let error = authViewModel.error else { return nil }
                return IdentifiableError(error: error)
            },
            set: { _ in
                authViewModel.error = nil
            }
        )
    }
}


// Identifiable Error Wrapper

struct IdentifiableError: Identifiable {
    let id = UUID()
    let error: AuthError

    var errorDescription: String {
        error.localizedDescription
    }
}


// Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(
                AuthViewModel(authRepository: MockAuthRepository())
            )
    }
}
