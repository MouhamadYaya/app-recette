import SwiftUI

// MARK: - Mock-only models (distinct from Supabase Transaction in Models/)

struct MockTransaction: Identifiable {
    let id = UUID()
    let day: Int
    let hour: String
    let icon: String
    let title: String
    let category: String
    let amount: Double
    var isRevenu: Bool { amount > 0 }

    var iconBackground: Color {
        switch category {
        case "Revenus":      return Color(hex: "#EDFAF3")!
        case "Alimentation": return Color(hex: "#FFF5E8")!
        case "Logement":     return Color(hex: "#FFF5E8")!
        default:             return Color(hex: "#EDF2FA")!
        }
    }
}

struct BudgetCategory: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    let budget: Double
    let spent: Double
    var remaining: Double { budget - spent }
    var progress: Double { min(spent / budget, 1.0) }
    var isOver: Bool { spent >= budget }
}

// MARK: - Mock Data

enum MockData {
    static let transactions: [MockTransaction] = [
        MockTransaction(day: 1,  hour: "09h00", icon: "💰", title: "Salaire Juin",      category: "Revenus",      amount: +2800.00),
        MockTransaction(day: 5,  hour: "10h40", icon: "🛒", title: "Monoprix",          category: "Courses",      amount:   -67.20),
        MockTransaction(day: 8,  hour: "14h33", icon: "🚗", title: "Uber",              category: "Transport",    amount:   -12.30),
        MockTransaction(day: 10, hour: "14h30", icon: "☕", title: "Coffee & Snacks",   category: "Alimentation", amount:    -8.50),
        MockTransaction(day: 14, hour: "20h15", icon: "🍽️", title: "Restaurant Mado",   category: "Alimentation", amount:   -42.00),
        MockTransaction(day: 18, hour: "08h00", icon: "⚡", title: "EDF",               category: "Logement",     amount:  -145.00),
        MockTransaction(day: 20, hour: "00h01", icon: "📱", title: "Netflix, Spotify…", category: "Abonnements",  amount:   -56.00),
        MockTransaction(day: 24, hour: "11h20", icon: "🛒", title: "Leclerc",           category: "Courses",      amount:  -127.40),
        MockTransaction(day: 26, hour: "20h00", icon: "🍽️", title: "Sushi Zen",         category: "Alimentation", amount:   -89.00),
    ]

    static let budgetCategories: [BudgetCategory] = [
        BudgetCategory(icon: "🛒", name: "Courses",      budget: 400,  spent: 194.60),
        BudgetCategory(icon: "🍽️", name: "Alimentation", budget: 200,  spent: 139.50),
        BudgetCategory(icon: "🚗", name: "Transport",    budget: 100,  spent:  12.30),
        BudgetCategory(icon: "🏠", name: "Logement",     budget: 1200, spent: 145.00),
        BudgetCategory(icon: "📱", name: "Abonnements",  budget: 80,   spent:  56.00),
        BudgetCategory(icon: "🎉", name: "Loisirs",      budget: 150,  spent:   0.00),
    ]

    static var totalRevenus: Double  { 2800.00 }
    static var totalDepenses: Double { 547.40 }
    static var solde: Double         { 3247.00 }

    static func transactions(forDay day: Int) -> [MockTransaction] {
        transactions.filter { $0.day == day }
    }

    static var daysWithTransactions: Set<Int> {
        Set(transactions.map { $0.day })
    }

    // Spending by category (for list view)
    static var spendingByCategory: [(icon: String, name: String, total: Double, color: Color)] {
        [
            ("💰", "Revenus",      2800, Color(hex: "#22C47A")!),
            ("🍽️", "Alimentation", 139.50, Color(hex: "#FF4E6A")!),
            ("🚗", "Transport",     12.30, Color(hex: "#FF4E6A")!),
            ("🏠", "Logement",     145.00, Color(hex: "#FF4E6A")!),
            ("📱", "Abonnements",   56.00, Color(hex: "#FF4E6A")!),
            ("🛒", "Courses",      194.60, Color(hex: "#FF4E6A")!),
        ]
    }
}
