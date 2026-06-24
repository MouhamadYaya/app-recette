import Foundation

enum TransactionType: String, Codable, CaseIterable {
    case income = "income"
    case expense = "expense"
}

struct Transaction: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let categoryId: UUID?
    let amount: Double
    let type: TransactionType
    let description: String
    let date: Date
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case categoryId = "category_id"
        case amount
        case type
        case description
        case date
        case createdAt = "created_at"
    }
}

extension Transaction {
    static func mock(type: TransactionType = .expense) -> Transaction {
        Transaction(
            id: UUID(),
            userId: UUID(),
            categoryId: UUID(),
            amount: type == .income ? 2800 : 67.20,
            type: type,
            description: type == .income ? "Salaire Juin" : "Monoprix",
            date: Date(),
            createdAt: Date()
        )
    }
}
