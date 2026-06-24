import SwiftUI

struct LightbulbView: View {
    let onNext: () -> Void

    private let points = [
        ("💡", "Suivez chaque euro", "Visualisez où va votre argent en temps réel."),
        ("🎯", "Atteignez vos objectifs", "Définissez des budgets et respectez-les facilement."),
        ("📊", "Analyses claires", "Des graphiques simples pour comprendre vos habitudes."),
    ]

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                Text("Maîtrisez\nvotre argent")
                    .font(.system(size: 36, weight: .black))
                    .foregroundColor(.evoNavy)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 48)

                VStack(spacing: 24) {
                    ForEach(points, id: \.0) { icon, title, subtitle in
                        HStack(alignment: .top, spacing: 16) {
                            Text(icon)
                                .font(.system(size: 32))
                                .frame(width: 48, height: 48)
                                .background(Color.white)
                                .cornerRadius(14)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(title)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.evoNavy)
                                Text(subtitle)
                                    .font(.system(size: 14))
                                    .foregroundColor(.evoGray)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 32)
                    }
                }

                Spacer()

                Button(action: onNext) {
                    Text("Continuer")
                }
                .evoButtonStyle()
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    LightbulbView(onNext: {})
}
