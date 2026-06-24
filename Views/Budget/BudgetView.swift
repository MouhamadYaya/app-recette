import SwiftUI

enum BudgetSubTab: String, CaseIterable {
    case programmer   = "Programmer"
    case ilReste      = "Il reste"
    case informations = "Informations"
}

struct BudgetView: View {
    @State private var selectedSubTab: BudgetSubTab = .programmer
    @State private var showSettingsModal = false

    private let darkText  = Color(hex: "#0F1923")!
    private let midGray   = Color(hex: "#6B7A99")!
    private let separator = Color(hex: "#F2F4F8")!

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                // Fixed header
                VStack(spacing: 0) {
                    topBar
                    progressCard
                    segmentedControl
                        .padding(.horizontal, 18)
                        .padding(.bottom, 14)
                    monthPicker
                        .padding(.horizontal, 18)
                        .padding(.bottom, 12)
                }

                // Scrollable body
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        switch selectedSubTab {
                        case .programmer:   programmerContent
                        case .ilReste:      ilResteContent
                        case .informations: informationsContent
                        }
                    }
                    .padding(.bottom, 16)
                }
            }
        }
        .sheet(isPresented: $showSettingsModal) {
            BudgetSettingsModal()
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            Button { showSettingsModal = true } label: {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 38, height: 38)
                        .shadow(color: Color.evoNavy.opacity(0.09), radius: 6, x: 0, y: 2)
                        .overlay(Circle().stroke(Color.white.opacity(0.5), lineWidth: 1))
                    Text("⚙️").font(.system(size: 16))
                }
            }
            Spacer()
            VStack(spacing: 1) {
                Text("Budget").font(.system(size: 11, weight: .medium)).foregroundColor(midGray)
                Text("Mon foyer").font(.system(size: 14, weight: .black)).foregroundColor(darkText)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 38, height: 38)
                    .shadow(color: Color.evoNavy.opacity(0.09), radius: 6, x: 0, y: 2)
                    .overlay(Circle().stroke(Color.white.opacity(0.5), lineWidth: 1))
                Text("📤").font(.system(size: 16))
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }

    // MARK: - Progress Card

    private var progressCard: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Juin 2026").font(.system(size: 12, weight: .semibold)).foregroundColor(.evoGray)
                Spacer()
                Text("42%").font(.system(size: 12, weight: .black)).foregroundColor(Color.evoNavy)
            }
            .padding(.bottom, 10)

            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "#EDF0F5")!)
                .frame(height: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.evoNavy)
                        .frame(width: nil)
                        .scaleEffect(x: 0.42, anchor: .leading),
                    alignment: .leading
                )
                .padding(.bottom, 12)

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("1 247 €")
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(darkText)
                        .kerning(-0.5)
                    Text("DÉPENSÉ")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.evoGray)
                        .kerning(0.5)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("1 753 €")
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(darkText)
                        .kerning(-0.5)
                    Text("RESTE · 8 JOURS")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.evoGray)
                        .kerning(0.5)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.evoNavy.opacity(0.10), radius: 16, x: 0, y: 4)
        .padding(.horizontal, 18)
        .padding(.bottom, 14)
    }

    // MARK: - Segmented Control

    private var segmentedControl: some View {
        HStack(spacing: 0) {
            ForEach(BudgetSubTab.allCases, id: \.self) { tab in
                Button { selectedSubTab = tab } label: {
                    Text(tab.rawValue)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(selectedSubTab == tab ? .white : .evoGray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(selectedSubTab == tab ? Color.evoNavy : Color.clear)
                        .cornerRadius(18)
                }
            }
        }
        .padding(3)
        .background(Color.white.opacity(0.78))
        .cornerRadius(22)
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.white.opacity(0.5), lineWidth: 1))
        .shadow(color: Color.evoNavy.opacity(0.06), radius: 6, x: 0, y: 2)
    }

    // MARK: - Month Picker

    private var monthPicker: some View {
        HStack {
            Text("‹").font(.system(size: 16)).foregroundColor(.evoGray)
            Spacer()
            Text("Juin 2026").font(.system(size: 13, weight: .bold)).foregroundColor(darkText)
            Spacer()
            Text("›").font(.system(size: 16)).foregroundColor(.evoGray)
        }
        .padding(.horizontal, 14).padding(.vertical, 9)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.evoNavy.opacity(0.06), radius: 6, x: 0, y: 2)
    }

    // MARK: - Programmer

    private var programmerContent: some View {
        VStack(spacing: 10) {
            budgetGroup(
                title: "💰 Revenus",
                items: [("💼", Color(hex: "#EDFAF3")!, "Salaire", "2 800 €")]
            )
            budgetGroup(
                title: "🏠 Logement",
                items: [
                    ("🏛️", Color(hex: "#FFF5E8")!, "Loyer", "900 €"),
                    ("⚡", Color(hex: "#FFF5E8")!, "Électricité", "145 €"),
                ]
            )
            budgetGroup(
                title: "🍽️ Alimentation",
                items: [
                    ("🛒", Color(hex: "#EDF2FA")!, "Courses", "400 €"),
                    ("🍴", Color(hex: "#FFF5E8")!, "Restaurants", "200 €"),
                ]
            )
            budgetGroup(
                title: "🐷 Économies",
                items: [("🎯", Color(hex: "#EDF2FA")!, "Épargne mensuelle", "200 €")]
            )
        }
        .padding(.horizontal, 18)
    }

    private func budgetGroup(title: String, items: [(String, Color, String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 13, weight: .black))
                .foregroundColor(darkText)
                .padding(.bottom, 10)

            ForEach(Array(items.enumerated()), id: \.offset) { idx, item in
                HStack(spacing: 9) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7).fill(item.1).frame(width: 26, height: 26)
                        Text(item.0).font(.system(size: 13))
                    }
                    Text(item.2).font(.system(size: 13, weight: .semibold)).foregroundColor(darkText)
                    Spacer()
                    Text(item.3).font(.system(size: 13, weight: .bold)).foregroundColor(darkText)
                }
                .padding(.vertical, 8)
                if idx < items.count - 1 {
                    Divider()
                }
            }

            // Add button
            HStack(spacing: 7) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(hex: "#C8D0DC")!, lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                    Text("+").font(.system(size: 12)).foregroundColor(.evoGray)
                }
                Text("Ajouter").font(.system(size: 12)).foregroundColor(.evoGray)
            }
            .padding(.top, 8)
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: Color.evoNavy.opacity(0.07), radius: 10, x: 0, y: 2)
    }

    // MARK: - Il reste

    private var ilResteContent: some View {
        VStack(spacing: 10) {
            // Daily budget card
            VStack(alignment: .leading, spacing: 12) {
                Text("Budget quotidien")
                    .font(.system(size: 13, weight: .black))
                    .foregroundColor(darkText)

                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13).fill(Color.evoNavy).frame(width: 44, height: 44)
                        VStack(spacing: 0) {
                            Text("8").font(.system(size: 17, weight: .black)).foregroundColor(.white)
                            Text("jours").font(.system(size: 8, weight: .medium)).foregroundColor(.white.opacity(0.65)).kerning(0.5)
                        }
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("219 €")
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(darkText)
                            .kerning(-0.5)
                        Text("PAR JOUR RESTANT")
                            .font(.system(size: 9)).foregroundColor(.evoGray).kerning(1)
                    }
                }
                .padding(12)
                .background(Color(hex: "#EDF2FA")!)
                .cornerRadius(13)
            }
            .padding(14)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.evoNavy.opacity(0.07), radius: 10, x: 0, y: 2)

            // Category breakdown
            VStack(alignment: .leading, spacing: 0) {
                Text("Répartition du budget")
                    .font(.system(size: 13, weight: .black))
                    .foregroundColor(darkText)
                    .padding(.bottom, 12)

                ForEach(MockData.budgetCategories) { cat in
                    VStack(spacing: 5) {
                        HStack {
                            Text("\(cat.icon) \(cat.name)")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(darkText)
                            Spacer()
                            Text("\(Int(cat.spent)) / \(Int(cat.budget)) €")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(cat.isOver ? .evoRed : darkText)
                        }
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(hex: "#EDF0F5")!)
                                    .frame(height: 6)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(cat.isOver ? Color.evoRed : Color.evoNavy)
                                    .frame(width: geo.size.width * cat.progress, height: 6)
                            }
                        }
                        .frame(height: 6)
                        .padding(.bottom, 8)
                    }
                }
            }
            .padding(14)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.evoNavy.opacity(0.07), radius: 10, x: 0, y: 2)
        }
        .padding(.horizontal, 18)
    }

    // MARK: - Informations

    private var informationsContent: some View {
        VStack(spacing: 10) {
            infoCard(title: "Résumé du mois") {
                infoRow("Budget total", value: "3 000 €")
                Divider()
                infoRow("Total dépensé", value: "1 247 €", color: .evoRed)
                Divider()
                infoRow("Restant", value: "1 753 €", color: .evoGreen)
                Divider()
                infoRow("Économies prévues", value: "200 €", color: .evoNavy)
            }

            infoCard(title: "Catégories") {
                ForEach(Array(MockData.budgetCategories.enumerated()), id: \.offset) { idx, cat in
                    HStack {
                        Text("\(cat.icon) \(cat.name)")
                            .font(.system(size: 13)).foregroundColor(darkText)
                        Spacer()
                        Text("\(Int(cat.progress * 100)) %")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(cat.isOver ? .evoRed : .evoGreen)
                    }
                    .padding(.vertical, 4)
                    if idx < MockData.budgetCategories.count - 1 {
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 18)
    }

    private func infoCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 13, weight: .black))
                .foregroundColor(darkText)
            content()
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: Color.evoNavy.opacity(0.07), radius: 10, x: 0, y: 2)
    }

    private func infoRow(_ label: String, value: String, color: Color = Color(hex: "#0F1923")!) -> some View {
        HStack {
            Text(label).font(.system(size: 13)).foregroundColor(.evoGray)
            Spacer()
            Text(value).font(.system(size: 13, weight: .bold)).foregroundColor(color)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Budget Settings Modal

struct BudgetSettingsModal: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nom du budget")
                        .font(.system(size: 13)).foregroundColor(.evoGray)
                    TextField("Ex: Mon foyer", text: .constant("Mon foyer"))
                        .padding(14)
                        .background(Color(hex: "#F2F4F8")!)
                        .cornerRadius(12)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Budget total mensuel (€)")
                        .font(.system(size: 13)).foregroundColor(.evoGray)
                    TextField("Ex: 3000", text: .constant("3000"))
                        .keyboardType(.decimalPad)
                        .padding(14)
                        .background(Color(hex: "#F2F4F8")!)
                        .cornerRadius(12)
                }
                Spacer()
                Button { dismiss() } label: { Text("Enregistrer") }
                    .evoButtonStyle()
            }
            .padding(24)
            .navigationTitle("Paramètres budget")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }.foregroundColor(Color.evoNavy)
                }
            }
        }
    }
}

#Preview {
    BudgetView()
}
