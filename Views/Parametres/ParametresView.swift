import SwiftUI

struct ParametresView: View {
    @State private var showBankModal   = false
    @State private var notifEnabled   = true
    @State private var biometricEnabled = false
    @State private var currency        = "EUR (€)"

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    profileCard

                    settingsSection(title: "Préférences") {
                        toggleRow(icon: "bell.fill",      label: "Notifications",      isOn: $notifEnabled)
                        Divider().padding(.leading, 56)
                        toggleRow(icon: "faceid",         label: "Face ID / Touch ID", isOn: $biometricEnabled)
                        Divider().padding(.leading, 56)
                        pickerRow(icon: "eurosign.circle.fill", label: "Devise", value: currency)
                    }

                    settingsSection(title: "Compte") {
                        navRow(icon: "building.columns.fill", label: "Connexion bancaire", color: .evoGreen) {
                            showBankModal = true
                        }
                        Divider().padding(.leading, 56)
                        navRow(icon: "lock.fill", label: "Changer le mot de passe", color: .evoBlue) { }
                        Divider().padding(.leading, 56)
                        navRow(icon: "square.and.arrow.up", label: "Exporter mes données", color: .evoNavy) { }
                    }

                    settingsSection(title: "Support") {
                        navRow(icon: "questionmark.circle.fill", label: "Aide & FAQ",           color: .evoGray) { }
                        Divider().padding(.leading, 56)
                        navRow(icon: "star.fill",                label: "Noter l'application",  color: Color(hex: "#F4A261")!) { }
                        Divider().padding(.leading, 56)
                        navRow(icon: "info.circle.fill",         label: "Version 1.0.0",        color: .evoGray) { }
                            .disabled(true)
                    }

                    Button {
                    } label: {
                        Text("Se déconnecter")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.evoRed)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.evoNavy.opacity(0.06), radius: 8, x: 0, y: 2)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 56)
                .padding(.bottom, 32)
            }
        }
        .sheet(isPresented: $showBankModal) {
            BankConnectionModal()
        }
    }

    // MARK: - Profile Card

    private var profileCard: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.evoNavy)
                    .frame(width: 60, height: 60)
                Text("👤")
                    .font(.system(size: 28))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Mon Profil")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.evoNavy)
                Text("Utilisateur Monevo")
                    .font(.system(size: 13))
                    .foregroundColor(.evoGray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.evoGray)
        }
        .padding(20)
        .evoCard()
        .padding(.horizontal, 20)
    }

    // MARK: - Section Builder

    private func settingsSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.evoGray)
                .padding(.horizontal, 20)

            VStack(spacing: 0) {
                content()
            }
            .evoCard()
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Row Types

    private func toggleRow(icon: String, label: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.evoNavy)
                .frame(width: 28)
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.evoDarkText)
            Spacer()
            Toggle("", isOn: isOn)
                .tint(.evoGreen)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    private func pickerRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.evoNavy)
                .frame(width: 28)
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.evoDarkText)
            Spacer()
            Text(value)
                .font(.system(size: 13))
                .foregroundColor(.evoGray)
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundColor(.evoGray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    private func navRow(icon: String, label: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                    .frame(width: 28)
                Text(label)
                    .font(.system(size: 14))
                    .foregroundColor(.evoDarkText)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.evoGray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
    }
}

// MARK: - Bank Connection Modal

struct BankConnectionModal: View {
    @Environment(\.dismiss) private var dismiss

    private let banks = [
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
                        .font(.system(size: 40))
                        .foregroundColor(.evoNavy)
                    Text("Connecter une banque")
                        .font(.system(size: 22, weight: .black))
                        .foregroundColor(.evoNavy)
                    Text("Synchronisez vos comptes automatiquement\npour un suivi en temps réel.")
                        .font(.system(size: 14))
                        .foregroundColor(.evoGray)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 24)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                VStack(spacing: 0) {
                    ForEach(banks, id: \.1) { icon, name in
                        Button {
                            dismiss()
                        } label: {
                            HStack(spacing: 14) {
                                Text(icon)
                                    .font(.system(size: 24))
                                    .frame(width: 44, height: 44)
                                    .background(Color.evoLightGray)
                                    .cornerRadius(12)
                                Text(name)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.evoDarkText)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13))
                                    .foregroundColor(.evoGray)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                        }
                        if name != banks.last?.1 {
                            Divider().padding(.leading, 78)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.evoNavy.opacity(0.06), radius: 8, x: 0, y: 2)
                .padding(.horizontal, 20)

                Spacer()

                Text("Connexion sécurisée · Certifiée DSP2")
                    .font(.system(size: 12))
                    .foregroundColor(.evoGray)
                    .padding(.bottom, 32)
            }
            .background(LinearGradient.evoBackground.ignoresSafeArea())
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                        .foregroundColor(.evoNavy)
                }
            }
        }
    }
}

#Preview {
    ParametresView()
}
