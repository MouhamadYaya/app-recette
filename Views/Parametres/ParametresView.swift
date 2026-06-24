import SwiftUI

struct ParametresView: View {
    @State private var showBankModal     = false
    @State private var notifEnabled      = true
    @State private var biometricEnabled  = false

    private let darkText  = Color(hex: "#0F1923")!
    private let midGray   = Color(hex: "#6B7A99")!
    private let chipBlue  = Color(hex: "#EDF2FA")!

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Heading
                    VStack(alignment: .leading, spacing: 2) {
                        Text("COMPTE")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(midGray)
                            .kerning(1)
                        Text("Paramètres")
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(darkText)
                            .kerning(-0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 18)
                    .padding(.top, 52)
                    .padding(.bottom, 20)

                    // User card
                    userCard.padding(.horizontal, 18).padding(.bottom, 18)

                    // Sections
                    sectionLabel("MON COMPTE")
                    sectionCard {
                        navRow(icon: "👤", iconBg: chipBlue, label: "Profil") {}
                        Divider().padding(.leading, 58)
                        navRow(icon: "🔑", iconBg: chipBlue, label: "Mot de passe") {}
                        Divider().padding(.leading, 58)
                        navRow(icon: "🏦", iconBg: Color(hex: "#EDFAF3")!, label: "Connexion bancaire") {
                            showBankModal = true
                        }
                    }
                    .padding(.horizontal, 18).padding(.bottom, 14)

                    sectionLabel("PRÉFÉRENCES")
                    sectionCard {
                        toggleRow(icon: "🔔", iconBg: chipBlue, label: "Notifications", isOn: $notifEnabled)
                        Divider().padding(.leading, 58)
                        toggleRow(icon: "🔒", iconBg: chipBlue, label: "Face ID / Touch ID", isOn: $biometricEnabled)
                        Divider().padding(.leading, 58)
                        navRow(icon: "💶", iconBg: chipBlue, label: "Devise — EUR (€)") {}
                    }
                    .padding(.horizontal, 18).padding(.bottom, 14)

                    sectionLabel("SUPPORT")
                    sectionCard {
                        navRow(icon: "❓", iconBg: chipBlue, label: "Aide & FAQ") {}
                        Divider().padding(.leading, 58)
                        navRow(icon: "⭐", iconBg: Color(hex: "#FFF5E8")!, label: "Noter l'application") {}
                        Divider().padding(.leading, 58)
                        navRow(icon: "ℹ️", iconBg: chipBlue, label: "Version 1.0.0") {}
                    }
                    .padding(.horizontal, 18).padding(.bottom, 20)

                    // Disconnect
                    Button {} label: {
                        Text("Se déconnecter")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.evoRed)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.evoNavy.opacity(0.07), radius: 8, x: 0, y: 2)
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 32)
                }
            }
        }
        .sheet(isPresented: $showBankModal) {
            BankConnectionModal()
        }
    }

    // MARK: - User Card

    private var userCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle().fill(Color.evoNavy).frame(width: 52, height: 52)
                Text("A").font(.system(size: 20, weight: .black)).foregroundColor(.white)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Alex Martin")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(darkText)
                Text("alex.martin@gmail.com")
                    .font(.system(size: 12))
                    .foregroundColor(.evoGray)
            }
            Spacer()
            Text("PREMIUM")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color.evoNavy)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(hex: "#EDF2FA")!)
                .cornerRadius(20)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.evoNavy.opacity(0.10), radius: 16, x: 0, y: 4)
    }

    // MARK: - Builders

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(.evoGray)
            .kerning(1.5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 7)
    }

    private func sectionCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) {
            content()
        }
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: Color.evoNavy.opacity(0.07), radius: 10, x: 0, y: 2)
    }

    private func navRow(icon: String, iconBg: Color, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 11) {
                ZStack {
                    RoundedRectangle(cornerRadius: 9).fill(iconBg).frame(width: 32, height: 32)
                    Text(icon).font(.system(size: 14))
                }
                Text(label).font(.system(size: 13, weight: .semibold)).foregroundColor(darkText)
                Spacer()
                Text("›").font(.system(size: 16)).foregroundColor(Color(hex: "#C8D0DC")!)
            }
            .padding(.horizontal, 15).padding(.vertical, 13)
        }
    }

    private func toggleRow(icon: String, iconBg: Color, label: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 11) {
            ZStack {
                RoundedRectangle(cornerRadius: 9).fill(iconBg).frame(width: 32, height: 32)
                Text(icon).font(.system(size: 14))
            }
            Text(label).font(.system(size: 13, weight: .semibold)).foregroundColor(darkText)
            Spacer()
            Toggle("", isOn: isOn).tint(.evoGreen).labelsHidden()
        }
        .padding(.horizontal, 15).padding(.vertical, 13)
    }
}

// MARK: - Bank Connection Modal

struct BankConnectionModal: View {
    @Environment(\.dismiss) private var dismiss
    private let darkText = Color(hex: "#0F1923")!

    private let banks: [(String, String)] = [
        ("🏦", "BNP Paribas"),
        ("🟢", "Société Générale"),
        ("🔵", "Crédit Agricole"),
        ("🟠", "Boursorama"),
        ("🟣", "LCL"),
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Image(systemName: "building.columns.fill")
                        .font(.system(size: 36)).foregroundColor(Color.evoNavy)
                    Text("Connecter une banque")
                        .font(.system(size: 20, weight: .black)).foregroundColor(darkText)
                    Text("Synchronisez vos comptes automatiquement\npour un suivi en temps réel.")
                        .font(.system(size: 13)).foregroundColor(.evoGray)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 28).padding(.horizontal, 32).padding(.bottom, 28)

                VStack(spacing: 0) {
                    ForEach(Array(banks.enumerated()), id: \.offset) { idx, bank in
                        Button { dismiss() } label: {
                            HStack(spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(hex: "#EDF2FA")!)
                                        .frame(width: 44, height: 44)
                                    Text(bank.0).font(.system(size: 22))
                                }
                                Text(bank.1).font(.system(size: 15, weight: .semibold)).foregroundColor(darkText)
                                Spacer()
                                Text("›").font(.system(size: 16)).foregroundColor(Color(hex: "#C8D0DC")!)
                            }
                            .padding(.horizontal, 20).padding(.vertical, 14)
                        }
                        if idx < banks.count - 1 {
                            Divider().padding(.leading, 78)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(18)
                .shadow(color: Color.evoNavy.opacity(0.06), radius: 10, x: 0, y: 2)
                .padding(.horizontal, 20)

                Spacer()

                Text("🔒 Connexion sécurisée · Certifiée DSP2")
                    .font(.system(size: 12)).foregroundColor(.evoGray)
                    .padding(.bottom, 32)
            }
            .background(LinearGradient.evoBackground.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }.foregroundColor(Color.evoNavy)
                }
            }
        }
    }
}

#Preview {
    ParametresView()
}
