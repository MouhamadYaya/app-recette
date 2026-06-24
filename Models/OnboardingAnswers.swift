import Foundation

// Q1 — Âge
enum AgeRange: String, Codable, CaseIterable {
    case under18 = "under_18"
    case age18to24 = "18_24"
    case age25to34 = "25_34"
    case age35to44 = "35_44"
    case age45to54 = "45_54"
    case over55 = "over_55"

    var label: String {
        switch self {
        case .under18:   return "Moins de 18 ans"
        case .age18to24: return "18 – 24 ans"
        case .age25to34: return "25 – 34 ans"
        case .age35to44: return "35 – 44 ans"
        case .age45to54: return "45 – 54 ans"
        case .over55:    return "55 ans et plus"
        }
    }
}

// Q2 — Expérience financière
enum FinancialExperience: String, Codable, CaseIterable {
    case none = "none"
    case beginner = "beginner"
    case intermediate = "intermediate"
    case advanced = "advanced"

    var label: String {
        switch self {
        case .none:         return "Aucune expérience"
        case .beginner:     return "Débutant"
        case .intermediate: return "Intermédiaire"
        case .advanced:     return "Avancé"
        }
    }
}

// Q3 — Niveau de stress financier
enum FinancialStress: String, Codable, CaseIterable {
    case none = "none"
    case low = "low"
    case medium = "medium"
    case high = "high"

    var label: String {
        switch self {
        case .none:   return "Aucun stress"
        case .low:    return "Peu stressant"
        case .medium: return "Assez stressant"
        case .high:   return "Très stressant"
        }
    }
}

// Q4 — Dépenses mensuelles estimées
enum MonthlyExpenses: String, Codable, CaseIterable {
    case under500 = "under_500"
    case e500to1000 = "500_1000"
    case e1000to2000 = "1000_2000"
    case e2000to3500 = "2000_3500"
    case over3500 = "over_3500"

    var label: String {
        switch self {
        case .under500:   return "Moins de 500 €"
        case .e500to1000: return "500 – 1 000 €"
        case .e1000to2000: return "1 000 – 2 000 €"
        case .e2000to3500: return "2 000 – 3 500 €"
        case .over3500:    return "Plus de 3 500 €"
        }
    }
}

// Q5 — Méthode de gestion actuelle
enum ManagementMethod: String, Codable, CaseIterable {
    case none = "none"
    case spreadsheet = "spreadsheet"
    case app = "app"
    case bank = "bank"
    case envelope = "envelope"

    var label: String {
        switch self {
        case .none:        return "Aucune méthode"
        case .spreadsheet: return "Tableur (Excel / Sheets)"
        case .app:         return "Application mobile"
        case .bank:        return "Suivi bancaire uniquement"
        case .envelope:    return "Méthode des enveloppes"
        }
    }
}

// Q6 — Crédit
enum CreditSituation: String, Codable, CaseIterable {
    case none = "none"
    case mortgage = "mortgage"
    case car = "car"
    case personal = "personal"
    case multiple = "multiple"

    var label: String {
        switch self {
        case .none:     return "Pas de crédit"
        case .mortgage: return "Crédit immobilier"
        case .car:      return "Crédit auto"
        case .personal: return "Crédit personnel"
        case .multiple: return "Plusieurs crédits"
        }
    }
}

// Q7 — Dettes
enum DebtSituation: String, Codable, CaseIterable {
    case none = "none"
    case low = "low"
    case medium = "medium"
    case high = "high"

    var label: String {
        switch self {
        case .none:   return "Pas de dettes"
        case .low:    return "Dettes légères (< 5 000 €)"
        case .medium: return "Dettes modérées (5 000 – 20 000 €)"
        case .high:   return "Dettes importantes (> 20 000 €)"
        }
    }
}

// Q8 — Partage des finances
enum FinanceSharingMode: String, Codable, CaseIterable {
    case solo = "solo"
    case partner = "partner"
    case family = "family"
    case roommates = "roommates"

    var label: String {
        switch self {
        case .solo:      return "Je gère seul(e)"
        case .partner:   return "En couple"
        case .family:    return "En famille"
        case .roommates: return "En colocation"
        }
    }
}

// Q9 — Abonnements
enum SubscriptionsCount: String, Codable, CaseIterable {
    case none = "none"
    case few = "1_3"
    case some = "4_7"
    case many = "8_plus"

    var label: String {
        switch self {
        case .none: return "Aucun abonnement"
        case .few:  return "1 – 3 abonnements"
        case .some: return "4 – 7 abonnements"
        case .many: return "8 abonnements et plus"
        }
    }
}

// Q10 — Factures récurrentes
enum BillsCount: String, Codable, CaseIterable {
    case none = "none"
    case few = "1_3"
    case some = "4_6"
    case many = "7_plus"

    var label: String {
        switch self {
        case .none: return "Aucune facture récurrente"
        case .few:  return "1 – 3 factures"
        case .some: return "4 – 6 factures"
        case .many: return "7 factures et plus"
        }
    }
}

// Modèle complet des réponses
struct OnboardingAnswers: Codable, Identifiable, Sendable {
    let id: UUID
    let userId: UUID
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
    var completedAt: Date?
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case ageRange = "age_range"
        case financialExperience = "financial_experience"
        case financialStress = "financial_stress"
        case monthlyExpenses = "monthly_expenses"
        case managementMethod = "management_method"
        case creditSituation = "credit_situation"
        case debtSituation = "debt_situation"
        case financeSharingMode = "finance_sharing_mode"
        case subscriptionsCount = "subscriptions_count"
        case billsCount = "bills_count"
        case completedAt = "completed_at"
        case createdAt = "created_at"
    }

    var isComplete: Bool { completedAt != nil }
}
