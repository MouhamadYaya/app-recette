import SwiftUI

struct CommunityView: View {
    let onNext: () -> Void

    private let stats = [
        ("🏆", "127 000+", "utilisateurs actifs"),
        ("⭐️", "4,8 / 5", "note moyenne"),
        ("💰", "2 400 €", "économisés en moyenne / an"),
    ]

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 12) {
                    Text("Rejoignez notre\ncommunauté")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.evoNavy)
                        .multilineTextAlignment(.center)

                    Text("Des milliers de personnes reprennent\nle contrôle de leurs finances avec MonEvo.")
                        .font(.system(size: 15))
                        .foregroundColor(.evoGray)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 48)

                VStack(spacing: 16) {
                    ForEach(stats, id: \.0) { icon, value, label in
                        HStack(spacing: 16) {
                            Text(icon)
                                .font(.system(size: 28))
                                .frame(width: 52, height: 52)
                                .background(Color.white)
                                .cornerRadius(14)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(value)
                                    .font(.system(size: 20, weight: .black))
                                    .foregroundColor(.evoNavy)
                                Text(label)
                                    .font(.system(size: 13))
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
    CommunityView(onNext: {})
}
