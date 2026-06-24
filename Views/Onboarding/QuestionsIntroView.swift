import SwiftUI

struct QuestionsIntroView: View {
    let onNext: () -> Void

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                Text("🐶")
                    .font(.system(size: 80))
                    .padding(.bottom, 32)

                VStack(spacing: 12) {
                    Text("Quelques questions\npour personnaliser\nvotre expérience")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(.evoNavy)
                        .multilineTextAlignment(.center)

                    Text("10 questions · environ 1 minute")
                        .font(.system(size: 15))
                        .foregroundColor(.evoGray)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 32)

                Spacer()

                Button(action: onNext) {
                    Text("C'est parti !")
                }
                .evoButtonStyle()
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    QuestionsIntroView(onNext: {})
}
