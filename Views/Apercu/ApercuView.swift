import SwiftUI
import Charts

enum ApercuSubTab: String, CaseIterable {
    case apercu   = "Aperçu"
    case depenses = "Dépenses"
    case liste    = "Liste"
}

struct ApercuView: View {
    @State private var selectedSubTab: ApercuSubTab = .apercu

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                header
                subTabPicker
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 8)

                ScrollView {
                    switch selectedSubTab {
                    case .apercu:   apercuContent
                    case .depenses: depensesContent
                    case .liste:    listeContent
                    }
                }
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 4) {
            Text("Juin 2026")
                .font(.system(size: 14))
                .foregroundColor(.evoGray)
            Text(MockData.solde.formatted())
                .font(.system(size: 40, weight: .black))
                .foregroundColor(.evoNavy)
            Text("Solde total")
                .font(.system(size: 13))
                .foregroundColor(.evoGray)

            HStack(spacing: 32) {
                statPill(label: "Revenus", value: "+\(MockData.totalRevenus.formatted())", color: .evoGreen)
                statPill(label: "Dépenses", value: "-\(MockData.totalDepenses.formatted())", color: .evoRed)
            }
            .padding(.top, 12)
        }
        .padding(.top, 56)
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
    }

    private func statPill(label: String, value: String, color: Color) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(color)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.evoGray)
        }
    }

    // MARK: - Sub-tab Picker

    private var subTabPicker: some View {
        HStack(spacing: 0) {
            ForEach(ApercuSubTab.allCases, id: \.self) { tab in
                Button { selectedSubTab = tab } label: {
                    Text(tab.rawValue)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(selectedSubTab == tab ? .white : .evoGray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedSubTab == tab ? Color.evoNavy : Color.clear)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(4)
        .background(Color.white.opacity(0.7))
        .cornerRadius(14)
    }

    // MARK: - Aperçu content

    private var apercuContent: some View {
        VStack(spacing: 16) {
            donutCard
            recentTransactionsCard
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }

    private var donutCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Répartition des dépenses")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.evoNavy)

            HStack(spacing: 24) {
                Chart {
                    ForEach(donutData, id: \.name) { item in
                        SectorMark(
                            angle: .value("Montant", item.amount),
                            innerRadius: .ratio(0.58),
                            angularInset: 2
                        )
                        .foregroundStyle(item.color)
                        .cornerRadius(4)
                    }
                }
                .frame(width: 120, height: 120)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(donutData, id: \.name) { item in
                        HStack(spacing: 8) {
                            Circle().fill(item.color).frame(width: 8, height: 8)
                            Text(item.name)
                                .font(.system(size: 12))
                                .foregroundColor(.evoNavy)
                            Spacer()
                            Text(item.amount.formatted())
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.evoNavy)
                        }
                    }
                }
            }
        }
        .padding(20)
        .evoCard()
    }

    private var donutData: [(name: String, amount: Double, color: Color)] {
        let cats = Dictionary(grouping: MockData.transactions.filter { !$0.isRevenu }, by: { $0.category })
        return cats.map { key, txns in
            (name: key, amount: txns.reduce(0) { $0 + abs($1.amount) }, color: colorFor(key))
        }.sorted { $0.amount > $1.amount }
    }

    private func colorFor(_ category: String) -> Color {
        switch category {
        case "Courses":      return .evoNavy
        case "Alimentation": return .evoGreen
        case "Transport":    return .evoBlue
        case "Logement":     return Color(hex: "#F4A261")!
        case "Abonnements":  return Color(hex: "#9B59B6")!
        default:             return .evoGray
        }
    }

    private var recentTransactionsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transactions récentes")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.evoNavy)

            ForEach(Array(MockData.transactions.suffix(5).reversed())) { txn in
                transactionRow(txn)
            }
        }
        .padding(20)
        .evoCard()
    }

    // MARK: - Dépenses content

    private var depensesContent: some View {
        VStack(spacing: 16) {
            ForEach(MockData.budgetCategories) { cat in
                HStack(spacing: 14) {
                    Text(cat.icon)
                        .font(.system(size: 22))
                        .frame(width: 44, height: 44)
                        .background(Color.evoLightGray)
                        .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(cat.name)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.evoNavy)
                            Spacer()
                            Text(cat.spent.formatted())
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.evoNavy)
                        }

                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.evoLightGray)
                                    .frame(height: 6)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(cat.progress > 0.9 ? Color.evoRed : Color.evoGreen)
                                    .frame(width: geo.size.width * cat.progress, height: 6)
                            }
                        }
                        .frame(height: 6)

                        Text("sur \(cat.budget.formatted())")
                            .font(.system(size: 11))
                            .foregroundColor(.evoGray)
                    }
                }
                .padding(16)
                .evoCard()
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }

    // MARK: - Liste content

    private var listeContent: some View {
        VStack(spacing: 8) {
            ForEach(Array(MockData.transactions.reversed())) { txn in
                transactionRow(txn)
                    .padding(16)
                    .evoCard()
                    .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 16)
    }

    // MARK: - Shared

    private func transactionRow(_ txn: MockTransaction) -> some View {
        HStack(spacing: 12) {
            Text(txn.icon)
                .font(.system(size: 20))
                .frame(width: 40, height: 40)
                .background(Color.evoLightGray)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(txn.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.evoNavy)
                Text(txn.category)
                    .font(.system(size: 12))
                    .foregroundColor(.evoGray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(txn.isRevenu ? "+\(txn.amount.formatted())" : "-\(abs(txn.amount).formatted())")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(txn.isRevenu ? .evoGreen : .evoRed)
                Text("Juin \(txn.day)")
                    .font(.system(size: 11))
                    .foregroundColor(.evoGray)
            }
        }
    }
}

#Preview {
    ApercuView()
}
