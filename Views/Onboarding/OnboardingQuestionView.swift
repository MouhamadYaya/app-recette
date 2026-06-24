import SwiftUI

struct OnboardingQuestionView<T: RawRepresentable & CaseIterable & Hashable>: View
    where T.RawValue == String, T.AllCases: RandomAccessCollection
{
    let questionNumber: Int
    let title: String
    let subtitle: String?
    let cases: T.Type
    let labelFor: (T) -> String
    @Binding var selection: T?
    let onNext: () -> Void

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Question \(questionNumber)/10")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.evoGray)

                    Text(title)
                        .font(.system(size: 26, weight: .black))
                        .foregroundColor(.evoNavy)

                    if let sub = subtitle {
                        Text(sub)
                            .font(.system(size: 15))
                            .foregroundColor(.evoGray)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 32)

                // Options
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(Array(T.allCases), id: \.self) { option in
                            Button {
                                selection = option
                            } label: {
                                HStack {
                                    Text(labelFor(option))
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(selection == option ? .white : .evoNavy)
                                    Spacer()
                                    if selection == option {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 18)
                                .background(selection == option ? Color.evoNavy : Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color.evoNavy.opacity(0.07), radius: 8, x: 0, y: 3)
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.bottom, 24)
                }

                Spacer()

                Button(action: onNext) {
                    Text(selection == nil ? "Passer" : "Continuer")
                }
                .evoButtonStyle()
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
        }
    }
}
