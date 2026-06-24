import SwiftUI

struct SocialProofView: View {
    let onNext: () -> Void

    private let testimonials = [
        ("Sophie M.", "⭐️⭐️⭐️⭐️⭐️", "J'ai économisé 3 200 € en 6 mois grâce à MonEvo. Les alertes budget ont tout changé !"),
        ("Thomas L.", "⭐️⭐️⭐️⭐️⭐️", "Enfin une app qui comprend mes besoins. Simple, rapide, efficace."),
        ("Amina K.", "⭐️⭐️⭐️⭐️⭐️", "Je recommande à tous mes amis. MonEvo m'a aidée à rembourser mes dettes."),
    ]

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text("Ils nous font\nconfiance")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.evoNavy)
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(testimonials, id: \.0) { name, stars, text in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(stars)
                                    .font(.system(size: 14))

                                Text(text)
                                    .font(.system(size: 15))
                                    .foregroundColor(.evoNavy)
                                    .fixedSize(horizontal: false, vertical: true)

                                Text("— \(name)")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.evoGray)
                            }
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(18)
                            .shadow(color: Color.evoNavy.opacity(0.07), radius: 10, x: 0, y: 4)
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.bottom, 24)
                }

                Button(action: onNext) {
                    Text("Voir les offres")
                }
                .evoButtonStyle()
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    SocialProofView(onNext: {})
}
