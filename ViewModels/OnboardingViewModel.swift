import Foundation
import SwiftUI
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {

    @Published var currentStep: Int = 0
    @Published var answers = PartialAnswers()
    @Published var isCompleted = false

    let totalSteps = 19

    struct PartialAnswers {
        var ageRange: AgeRange?
        var financialExperience: FinancialExperience?
        var financialStress: FinancialStress?
        var monthlyExpenses: MonthlyExpenses?
        var managementMethod: ManagementMethod?
        var creditSituation: CreditSituation?
        var debtSituation: DebtSituation?
        var financeSharingMode: FinanceSharingMode?
        var subscriptionsCount: SubscriptionsCount?
        var billsCount: BillsCount?
    }

    func next() {
        if currentStep < totalSteps - 1 {
            withAnimation(.easeInOut(duration: 0.35)) {
                currentStep += 1
            }
        } else {
            isCompleted = true
        }
    }

    func back() {
        if currentStep > 0 {
            withAnimation(.easeInOut(duration: 0.35)) {
                currentStep -= 1
            }
        }
    }

    var progress: Double {
        Double(currentStep) / Double(totalSteps - 1)
    }

    var showBackButton: Bool { currentStep > 0 }
}
