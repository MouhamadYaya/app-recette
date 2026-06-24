import SwiftUI

// MARK: - Mock-only models (distinct from Supabase Transaction in Models/)

struct MockTransaction: Identifiable {
    let id = UUID()
    let day: Int
    let icon: String
    let title: String
    let category: String
    let amount: Double
    var isRevenu: Bool { amount > 0 }
}

struct BudgetCategory: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    let budget: Double
    let spent: Double
    var remaining: Double { budget - spent }
    var progress: Double { min(spent / budget, 1.0) }
}

// MARK: - Mock Data

enum MockData {
    static let transactions: [MockTransaction] = [
        MockTransaction(day: 1,  icon: "💰", title: "Salaire Juin",      category: "Revenus",      amount: +2800.00),
        MockTransaction(day: 5,  icon: "🛒", title: "Monoprix",          category: "Courses",      amount:   -67.20),
        MockTransaction(day: 8,  icon: "🚗", title: "Uber",              category: "Transport",    amount:   -12.30),
        MockTransaction(day: 10, icon: "☕", title: "Coffee & Snacks",   category: "Alimentation", amount:    -8.50),
        MockTransaction(day: 14, icon: "🍽️", title: "Restaurant Mado",   category: "Alimentation", amount:   -42.00),
        MockTransaction(day: 18, icon: "⚡", title: "EDF",               category: "Logement",     amount:  -145.00),
        MockTransaction(day: 20, icon: "📱", title: "Netflix, Spotify…", category: "Abonnements",  amount:   -56.00),
        MockTransaction(day: 24, icon: "🛒", title: "Leclerc",           category: "Courses",      amount:  -127.40),
        MockTransaction(day: 26, icon: "🍽️", title: "Sushi Zen",         category: "Alimentation", amount:   -89.00),
    ]

    static let budgetCategories: [BudgetCategory] = [
        BudgetCategory(icon: "🛒", name: "Courses",      budget: 400,  spent: 194.60),
        BudgetCategory(icon: "🍽️", name: "Alimentation", budget: 200,  spent: 139.50),
        BudgetCategory(icon: "🚗", name: "Transport",    budget: 100,  spent:  12.30),
        BudgetCategory(icon: "🏠", name: "Logement",     budget: 1200, spent: 145.00),
        BudgetCategory(icon: "📱", name: "Abonnements",  budget: 80,   spent:  56.00),
        BudgetCategory(icon: "🎉", name: "Loisirs",      budget: 150,  spent:   0.00),
    ]

    static var totalRevenus: Double  { transactions.filter { $0.isRevenu }.reduce(0) { $0 + $1.amount } }
    static var totalDepenses: Double { transactions.filter { !$0.isRevenu }.reduce(0) { $0 + abs($1.amount) } }
    static var solde: Double { 2847.30 }

    static func transactions(forDay day: Int) -> [MockTransaction] {
        transactions.filter { $0.day == day }
    }

    static var daysWithTransactions: Set<Int> {
        Set(transactions.map { $0.day })
    }
}
