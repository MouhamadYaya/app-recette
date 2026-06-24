import Foundation

enum BudgetPeriod: String, Codable {
    case weekly = "weekly"
    case monthly = "monthly"
}

struct Budget: Codable, Identifiable, Sendable {
    let id: UUID
    let userId: UUID
    let categoryId: UUID
    let amount: Double
    let period: BudgetPeriod
    let startDate: Date
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case categoryId = "category_id"
        case amount
        case period
        case startDate = "start_date"
        case createdAt = "created_at"
    }
}

struct BudgetWithSpending: Sendable {
    let budget: Budget
    let category: Category
    let spent: Double

    var remaining: Double { max(0, budget.amount - spent) }
    var progress: Double { min(1.0, spent / budget.amount) }
    var isOverBudget: Bool { spent > budget.amount }
}
