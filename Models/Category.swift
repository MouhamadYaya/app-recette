import Foundation
import SwiftUI

struct Category: Codable, Identifiable, Sendable {
    let id: UUID
    let userId: UUID?
    let name: String
    let icon: String
    let color: String
    let type: TransactionType
    let isDefault: Bool
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case icon
        case color
        case type
        case isDefault = "is_default"
        case createdAt = "created_at"
    }
}

extension Category {
    var swiftUIColor: Color {
        Color(hex: color) ?? .gray
    }

    static let defaults: [Category] = [
        Category(id: UUID(), userId: nil, name: "Alimentation",  icon: "🍽️", color: "#FF6B6B", type: .expense, isDefault: true, createdAt: Date()),
        Category(id: UUID(), userId: nil, name: "Transport",     icon: "🚗", color: "#4ECDC4", type: .expense, isDefault: true, createdAt: Date()),
        Category(id: UUID(), userId: nil, name: "Logement",      icon: "🏠", color: "#45B7D1", type: .expense, isDefault: true, createdAt: Date()),
        Category(id: UUID(), userId: nil, name: "Courses",       icon: "🛒", color: "#96CEB4", type: .expense, isDefault: true, createdAt: Date()),
        Category(id: UUID(), userId: nil, name: "Abonnements",   icon: "📱", color: "#FFEAA7", type: .expense, isDefault: true, createdAt: Date()),
        Category(id: UUID(), userId: nil, name: "Santé",         icon: "💊", color: "#DDA0DD", type: .expense, isDefault: true, createdAt: Date()),
        Category(id: UUID(), userId: nil, name: "Loisirs",       icon: "🎭", color: "#F0A500", type: .expense, isDefault: true, createdAt: Date()),
        Category(id: UUID(), userId: nil, name: "Revenus",       icon: "💰", color: "#22C47A", type: .income,  isDefault: true, createdAt: Date()),
    ]
}
