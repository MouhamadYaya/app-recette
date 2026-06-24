import SwiftUI

struct FeaturesView: View {
    let onNext: () -> Void

    private let features = [
        ("📊", "Tableau de bord personnalisé", true),
        ("🔔", "Alertes budget en temps réel", true),
        ("🏦", "Connexion bancaire sécurisée", true),
        ("📅", "Calendrier des dépenses", true),
        ("🎯", "Objectifs d'épargne", true),
        ("📈", "Rapports mensuels", true),
    ]

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text("Fonctionnalités\nactivées pour vous")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(.evoNavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)

                    Text("Basées sur vos réponses")
                        .font(.system(size: 14))
                        .foregroundColor(.evoGray)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(features, id: \.0) { icon, title, _ in
                            HStack(spacing: 14) {
                                Text(icon)
                                    .font(.system(size: 22))
                                    .frame(width: 44, height: 44)
                                    .background(Color.white)
                                    .cornerRadius(12)

                                Text(title)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.evoNavy)

                                Spacer()

                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.evoGreen)
                                    .font(.system(size: 20))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .cornerRadius(16)
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.bottom, 24)
                }

                Button(action: onNext) {
                    Text("Continuer")
                }
                .evoButtonStyle()
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    FeaturesView(onNext: {})
}
