import SwiftUI

struct WelcomeView: View {
    let onNext: () -> Void

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Logo
                ZStack {
                    Circle()
                        .fill(Color.evoNavy)
                        .frame(width: 120, height: 120)
                    Text("🐷")
                        .font(.system(size: 64))
                }
                .padding(.bottom, 40)

                // Titre
                VStack(spacing: 12) {
                    Text("MonEvo")
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(.evoNavy)

                    Text("Votre argent,\nsous contrôle.")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.evoNavy.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 16)

                Text("Gérez vos dépenses, atteignez vos objectifs\net prenez le contrôle de vos finances.")
                    .font(.system(size: 16))
                    .foregroundColor(.evoGray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                // CTA
                Button(action: onNext) {
                    Text("Commencer")
                }
                .evoButtonStyle()
                .padding(.horizontal, 32)
                .padding(.bottom, 16)

                Text("Gratuit · Sans engagement")
                    .font(.caption)
                    .foregroundColor(.evoGray)
                    .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    WelcomeView(onNext: {})
}
