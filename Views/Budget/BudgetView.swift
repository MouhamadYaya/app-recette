import SwiftUI

enum BudgetSubTab: String, CaseIterable {
    case programmer   = "Programmer"
    case ilReste      = "Il reste"
    case informations = "Informations"
}

struct BudgetView: View {
    @State private var selectedSubTab: BudgetSubTab = .programmer
    @State private var showSettingsModal = false
    @State private var editingCategory: BudgetCategory? = nil

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
                    case .programmer:   programmerContent
                    case .ilReste:      ilResteContent
                    case .informations: informationsContent
                    }
                }
            }
        }
        .sheet(isPresented: $showSettingsModal) {
            BudgetSettingsModal(category: editingCategory)
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 4) {
            Text("Budget · Juin 2026")
                .font(.system(size: 14))
                .foregroundColor(.evoGray)

            let totalBudget = MockData.budgetCategories.reduce(0) { $0 + $1.budget }
            let totalSpent  = MockData.budgetCategories.reduce(0) { $0 + $1.spent }

            Text(totalBudget.formatted())
                .font(.system(size: 40, weight: .black))
                .foregroundColor(.evoNavy)
            Text("Budget total")
                .font(.system(size: 13))
                .foregroundColor(.evoGray)

            HStack(spacing: 32) {
                statPill(label: "Dépensé",  value: totalSpent.formatted(),             color: .evoRed)
                statPill(label: "Restant",  value: (totalBudget - totalSpent).formatted(), color: .evoGreen)
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
            ForEach(BudgetSubTab.allCases, id: \.self) { tab in
                Button { selectedSubTab = tab } label: {
                    Text(tab.rawValue)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(selectedSubTab == tab ? .white : .evoGray)
                        .padding(.horizontal, 12)
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

    // MARK: - Programmer

    private var programmerContent: some View {
        VStack(spacing: 12) {
            ForEach(MockData.budgetCategories) { cat in
                budgetRow(cat)
            }

            Button {
                editingCategory = nil
                showSettingsModal = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                    Text("Ajouter une catégorie")
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.evoNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.white.opacity(0.8))
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.evoNavy.opacity(0.2), lineWidth: 1.5)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [6]))
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }

    private func budgetRow(_ cat: BudgetCategory) -> some View {
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
                    Text(cat.budget.formatted())
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

                HStack {
                    Text("\(cat.spent.formatted()) dépensés")
                        .font(.system(size: 11))
                        .foregroundColor(.evoGray)
                    Spacer()
                    Text("\(cat.remaining.formatted()) restants")
                        .font(.system(size: 11))
                        .foregroundColor(cat.remaining < 0 ? .evoRed : .evoGreen)
                }
            }

            Button {
                editingCategory = cat
                showSettingsModal = true
            } label: {
                Image(systemName: "pencil")
                    .font(.system(size: 14))
                    .foregroundColor(.evoGray)
            }
        }
        .padding(16)
        .evoCard()
    }

    // MARK: - Il reste

    private var ilResteContent: some View {
        VStack(spacing: 12) {
            ForEach(MockData.budgetCategories) { cat in
                HStack(spacing: 14) {
                    Text(cat.icon)
                        .font(.system(size: 22))
                        .frame(width: 44, height: 44)
                        .background(Color.evoLightGray)
                        .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(cat.name)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.evoNavy)
                        Text("sur \(cat.budget.formatted())")
                            .font(.system(size: 12))
                            .foregroundColor(.evoGray)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text(cat.remaining.formatted())
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(cat.remaining < 0 ? .evoRed : .evoNavy)
                        Text("restants")
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

    // MARK: - Informations

    private var informationsContent: some View {
        VStack(spacing: 12) {
            let totalBudget = MockData.budgetCategories.reduce(0) { $0 + $1.budget }
            let totalSpent  = MockData.budgetCategories.reduce(0) { $0 + $1.spent }
            let totalRemain = totalBudget - totalSpent

            infoRow(label: "Budget total du mois",  value: totalBudget.formatted(),  color: .evoNavy)
            infoRow(label: "Total dépensé",          value: totalSpent.formatted(),   color: .evoRed)
            infoRow(label: "Restant disponible",     value: totalRemain.formatted(),  color: .evoGreen)
            infoRow(label: "Nombre de catégories",   value: "\(MockData.budgetCategories.count)", color: .evoNavy)
            infoRow(label: "Catégorie la plus chère", value: "Logement",             color: .evoNavy)

            Divider().padding(.vertical, 4)

            ForEach(MockData.budgetCategories) { cat in
                HStack {
                    Text("\(cat.icon) \(cat.name)")
                        .font(.system(size: 13))
                        .foregroundColor(.evoNavy)
                    Spacer()
                    Text("\(Int(cat.progress * 100)) %")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(cat.progress > 0.9 ? .evoRed : .evoGreen)
                }
                .padding(.vertical, 4)
            }
        }
        .padding(20)
        .evoCard()
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }

    private func infoRow(label: String, value: String, color: Color) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(.evoGray)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(color)
        }
    }
}

// MARK: - Budget Settings Modal

struct BudgetSettingsModal: View {
    let category: BudgetCategory?
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var amount: String = ""

    init(category: BudgetCategory?) {
        self.category = category
        _name   = State(initialValue: category?.name ?? "")
        _amount = State(initialValue: category.map { "\(Int($0.budget))" } ?? "")
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nom de la catégorie")
                        .font(.system(size: 13))
                        .foregroundColor(.evoGray)
                    TextField("Ex: Courses, Loisirs…", text: $name)
                        .padding(14)
                        .background(Color.evoLightGray)
                        .cornerRadius(12)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Budget mensuel (€)")
                        .font(.system(size: 13))
                        .foregroundColor(.evoGray)
                    TextField("Ex: 300", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding(14)
                        .background(Color.evoLightGray)
                        .cornerRadius(12)
                }

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text(category == nil ? "Ajouter" : "Enregistrer")
                }
                .evoButtonStyle()
            }
            .padding(24)
            .navigationTitle(category == nil ? "Nouvelle catégorie" : "Modifier")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                        .foregroundColor(.evoNavy)
                }
            }
        }
    }
}

#Preview {
    BudgetView()
}
