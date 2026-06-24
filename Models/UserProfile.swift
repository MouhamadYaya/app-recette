import Foundation

enum Currency: String, Codable, CaseIterable {
    case eur = "EUR"
    case usd = "USD"
    case cad = "CAD"
    case gbp = "GBP"
    case chf = "CHF"

    var symbol: String {
        switch self {
        case .eur: return "€"
        case .usd: return "$"
        case .cad: return "CA$"
        case .gbp: return "£"
        case .chf: return "CHF"
        }
    }
}

struct UserProfile: Codable, Identifiable, Sendable {
    let id: UUID
    let userId: UUID
    var displayName: String
    var avatarUrl: String?
    var currency: Currency
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case displayName = "display_name"
        case avatarUrl = "avatar_url"
        case currency
        case createdAt = "created_at"
    }
}

extension UserProfile {
    static func mock() -> UserProfile {
        UserProfile(
            id: UUID(),
            userId: UUID(),
            displayName: "Mouhamad",
            avatarUrl: nil,
            currency: .eur,
            createdAt: Date()
        )
    }
}
