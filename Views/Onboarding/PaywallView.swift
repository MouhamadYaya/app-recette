import SwiftUI

enum PaywallStep: Int {
    case hook = 0
    case plans = 1
    case trial = 2
}

struct PaywallView: View {
    let step: PaywallStep
    let onNext: () -> Void
    let onSkip: () -> Void

    @State private var selectedPlan: PlanOption = .yearly

    enum PlanOption: String, CaseIterable {
        case monthly = "Mensuel"
        case yearly = "Annuel"

        var price: String {
            switch self {
            case .monthly: return "9,99 €/mois"
            case .yearly:  return "59,99 €/an"
            }
        }

        var perMonth: String {
            switch self {
            case .monthly: return "9,99 €/mois"
            case .yearly:  return "4,99 €/mois"
            }
        }

        var badge: String? {
            self == .yearly ? "Économisez 50 %" : nil
        }
    }

    var body: some View {
        ZStack {
            Color.evoNavy.ignoresSafeArea()

            VStack(spacing: 0) {
                switch step {
                case .hook:    hookContent
                case .plans:   plansContent
                case .trial:   trialContent
                }
            }
        }
    }

    // MARK: - Step 1 : Hook

    private var hookContent: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 20) {
                Text("💎")
                    .font(.system(size: 72))

                Text("Passez à\nMonEvo Pro")
                    .font(.system(size: 36, weight: .black))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("Accédez à toutes les fonctionnalités\npour transformer vos finances.")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)

            Spacer()

            Button(action: onNext) {
                Text("Voir les offres")
            }
            .foregroundColor(.evoNavy)
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 32)
            .padding(.bottom, 16)

            Button(action: onSkip) {
                Text("Continuer sans Pro")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.bottom, 50)
        }
    }

    // MARK: - Step 2 : Plans

    private var plansContent: some View {
        VStack(spacing: 0) {
            Text("Choisissez\nvotre offre")
                .font(.system(size: 32, weight: .black))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 48)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)

            VStack(spacing: 12) {
                ForEach(PlanOption.allCases, id: \.self) { plan in
                    Button { selectedPlan = plan } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 8) {
                                    Text(plan.rawValue)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(selectedPlan == plan ? .evoNavy : .white)
                                    if let badge = plan.badge {
                                        Text(badge)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 3)
                                            .background(Color.evoGreen)
                                            .cornerRadius(8)
                                    }
                                }
                                Text(plan.perMonth)
                                    .font(.system(size: 13))
                                    .foregroundColor(selectedPlan == plan ? .evoNavy.opacity(0.6) : .white.opacity(0.6))
                            }
                            Spacer()
                            Text(plan.price)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(selectedPlan == plan ? .evoNavy : .white)
                        }
                        .padding(20)
                        .background(selectedPlan == plan ? Color.white : Color.white.opacity(0.1))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(selectedPlan == plan ? Color.white : Color.white.opacity(0.2), lineWidth: 1.5)
                        )
                        .padding(.horizontal, 24)
                    }
                }
            }

            Spacer()

            Button(action: onNext) {
                Text("Commencer l'essai gratuit · 7 jours")
            }
            .foregroundColor(.evoNavy)
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 24)
            .padding(.bottom, 16)

            Button(action: onSkip) {
                Text("Continuer sans Pro")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.bottom, 50)
        }
    }

    // MARK: - Step 3 : Trial confirmation

    private var trialContent: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 20) {
                Text("🎉")
                    .font(.system(size: 72))

                Text("7 jours offerts !")
                    .font(.system(size: 36, weight: .black))
                    .foregroundColor(.white)

                Text("Profitez de toutes les fonctionnalités Pro\nsans engagement pendant 7 jours.\nAnnulez à tout moment.")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)

            Spacer()

            Button(action: onNext) {
                Text("Démarrer mon essai gratuit")
            }
            .foregroundColor(.evoNavy)
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 32)
            .padding(.bottom, 16)

            Button(action: onSkip) {
                Text("Non merci, continuer gratuitement")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    PaywallView(step: .plans, onNext: {}, onSkip: {})
}
