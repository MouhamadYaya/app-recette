import Foundation

enum FeedbackRating: Int, Codable, CaseIterable {
    case terrible = 1
    case bad = 2
    case okay = 3
    case good = 4
    case excellent = 5

    var emoji: String {
        switch self {
        case .terrible:  return "😞"
        case .bad:       return "😕"
        case .okay:      return "😐"
        case .good:      return "😊"
        case .excellent: return "🤩"
        }
    }

    var label: String {
        switch self {
        case .terrible:  return "Terrible"
        case .bad:       return "Mauvais"
        case .okay:      return "Correct"
        case .good:      return "Bien"
        case .excellent: return "Excellent"
        }
    }
}

struct Feedback: Codable, Identifiable {
    let id: UUID
    let userId: UUID?
    let rating: FeedbackRating
    let message: String?
    let screen: String?
    let appVersion: String?
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case rating
        case message
        case screen
        case appVersion = "app_version"
        case createdAt = "created_at"
    }
}
