import SwiftUI

struct OnboardingFlow: View {
    @StateObject private var vm = OnboardingViewModel()
    let onComplete: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            // Contenu de l'étape
            Group {
                switch vm.currentStep {
                case 0:
                    WelcomeView(onNext: vm.next)
                case 1:
                    LightbulbView(onNext: vm.next)
                case 2:
                    QuestionsIntroView(onNext: vm.next)
                case 3:
                    OnboardingQuestionView(
                        questionNumber: 1,
                        title: "Quel est votre âge ?",
                        subtitle: nil,
                        cases: AgeRange.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.ageRange,
                        onNext: vm.next
                    )
                case 4:
                    OnboardingQuestionView(
                        questionNumber: 2,
                        title: "Votre expérience financière ?",
                        subtitle: "Soyez honnête, c'est pour personnaliser vos conseils.",
                        cases: FinancialExperience.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.financialExperience,
                        onNext: vm.next
                    )
                case 5:
                    OnboardingQuestionView(
                        questionNumber: 3,
                        title: "Votre niveau de stress financier ?",
                        subtitle: nil,
                        cases: FinancialStress.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.financialStress,
                        onNext: vm.next
                    )
                case 6:
                    CommunityView(onNext: vm.next)
                case 7:
                    OnboardingQuestionView(
                        questionNumber: 4,
                        title: "Vos dépenses mensuelles estimées ?",
                        subtitle: "Toutes charges confondues.",
                        cases: MonthlyExpenses.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.monthlyExpenses,
                        onNext: vm.next
                    )
                case 8:
                    OnboardingQuestionView(
                        questionNumber: 5,
                        title: "Comment gérez-vous vos finances ?",
                        subtitle: nil,
                        cases: ManagementMethod.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.managementMethod,
                        onNext: vm.next
                    )
                case 9:
                    OnboardingQuestionView(
                        questionNumber: 6,
                        title: "Avez-vous des crédits en cours ?",
                        subtitle: nil,
                        cases: CreditSituation.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.creditSituation,
                        onNext: vm.next
                    )
                case 10:
                    OnboardingQuestionView(
                        questionNumber: 7,
                        title: "Avez-vous des dettes ?",
                        subtitle: nil,
                        cases: DebtSituation.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.debtSituation,
                        onNext: vm.next
                    )
                case 11:
                    OnboardingQuestionView(
                        questionNumber: 8,
                        title: "Comment gérez-vous vos finances ?",
                        subtitle: "En solo ou à plusieurs ?",
                        cases: FinanceSharingMode.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.financeSharingMode,
                        onNext: vm.next
                    )
                case 12:
                    OnboardingQuestionView(
                        questionNumber: 9,
                        title: "Combien d'abonnements avez-vous ?",
                        subtitle: "Streaming, musique, logiciels…",
                        cases: SubscriptionsCount.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.subscriptionsCount,
                        onNext: vm.next
                    )
                case 13:
                    OnboardingQuestionView(
                        questionNumber: 10,
                        title: "Combien de factures récurrentes ?",
                        subtitle: "Électricité, internet, assurances…",
                        cases: BillsCount.self,
                        labelFor: { $0.label },
                        selection: $vm.answers.billsCount,
                        onNext: vm.next
                    )
                case 14:
                    FeaturesView(onNext: vm.next)
                case 15:
                    SocialProofView(onNext: vm.next)
                case 16:
                    PaywallView(step: .hook, onNext: vm.next, onSkip: onComplete)
                case 17:
                    PaywallView(step: .plans, onNext: vm.next, onSkip: onComplete)
                case 18:
                    PaywallView(step: .trial, onNext: onComplete, onSkip: onComplete)
                default:
                    EmptyView()
                }
            }
            .transition(.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            ))
            .id(vm.currentStep)

            // Barre de progression (masquée sur paywall)
            if vm.currentStep < 16 && vm.currentStep > 0 {
                VStack(spacing: 0) {
                    ProgressBar(progress: vm.progress)
                        .padding(.horizontal, 24)
                        .padding(.top, 12)

                    if vm.showBackButton && vm.currentStep < 16 {
                        HStack {
                            Button(action: vm.back) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.evoNavy)
                                    .padding(10)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 14)
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: vm.currentStep)
    }
}

// MARK: - Progress Bar

private struct ProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.evoNavy.opacity(0.12))
                    .frame(height: 4)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.evoNavy)
                    .frame(width: geo.size.width * progress, height: 4)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 4)
    }
}

#Preview {
    OnboardingFlow(onComplete: {})
}
