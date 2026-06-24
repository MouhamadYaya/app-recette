import SwiftUI

enum MainTab: String, CaseIterable {
    case apercu     = "Aperçu"
    case budget     = "Budget"
    case calendrier = "Calendrier"
    case parametres = "Par."

    var label: String {
        switch self {
        case .apercu:     return "Aperçu"
        case .budget:     return "Budget"
        case .calendrier: return "Calendrier"
        case .parametres: return "Paramètres"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .apercu
    @State private var showAddExpense = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // Content
            ZStack {
                switch selectedTab {
                case .apercu:     ApercuView()
                case .budget:     BudgetView()
                case .calendrier: CalendrierView()
                case .parametres: ParametresView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 84)

            // Nav bar with center + bump
            navBar
                .padding(.horizontal, 14)
                .padding(.bottom, 20)
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $showAddExpense) {
            AddExpenseSheet()
                .presentationDetents([.height(480)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(28)
        }
    }

    // MARK: - Nav Bar

    private var navBar: some View {
        ZStack(alignment: .bottom) {
            // Background pill
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.evoNavy)
                .frame(height: 72)
                .shadow(color: Color.evoNavy.opacity(0.35), radius: 20, x: 0, y: 8)
                .shadow(color: Color.evoNavy.opacity(0.15), radius: 6, x: 0, y: 2)

            // Tab items row
            HStack(spacing: 0) {
                // Left tabs
                navItem(.apercu)
                navItem(.budget)

                // Center spacer for the elevated button
                Spacer().frame(width: 80)

                // Right tabs
                navItem(.calendrier)
                navItem(.parametres)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)

            // Elevated center + button
            Button { showAddExpense = true } label: {
                ZStack {
                    Circle()
                        .fill(Color.evoNavy)
                        .frame(width: 62, height: 62)
                        .shadow(color: Color.evoNavy.opacity(0.4), radius: 12, x: 0, y: -4)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.15), lineWidth: 1.5)
                        )
                    Image(systemName: "plus")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .offset(y: -22)
        }
    }

    // MARK: - Nav Item

    @ViewBuilder
    private func navItem(_ tab: MainTab) -> some View {
        let isActive = selectedTab == tab
        Button { selectedTab = tab } label: {
            VStack(spacing: 3) {
                navIcon(tab, active: isActive)
                    .frame(width: 22, height: 22)
                Text(tab.label)
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(isActive ? .white : Color.white.opacity(0.45))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
        }
    }

    @ViewBuilder
    private func navIcon(_ tab: MainTab, active: Bool) -> some View {
        let c = active ? Color.white : Color.white.opacity(0.45)
        switch tab {
        case .apercu:
            ZStack {
                Circle().stroke(c, lineWidth: 1.8)
                Circle().fill(c).frame(width: 6, height: 6)
            }
        case .budget:
            RoundedRectangle(cornerRadius: 3).stroke(c, lineWidth: 1.8)
                .overlay(
                    VStack(spacing: 3) {
                        RoundedRectangle(cornerRadius: 1).fill(c).frame(height: 1.5)
                        HStack { RoundedRectangle(cornerRadius: 1).fill(c).frame(width: 8, height: 1.5); Spacer() }
                        RoundedRectangle(cornerRadius: 1).fill(c).frame(height: 1.5)
                    }.padding(.horizontal, 4).padding(.vertical, 4)
                )
        case .calendrier:
            Image(systemName: "calendar")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(c)
        case .parametres:
            ZStack {
                Circle().stroke(c, lineWidth: 1.8).frame(width: 8, height: 8).offset(y: -4)
                Path { p in
                    p.addArc(center: CGPoint(x: 10, y: 20), radius: 7, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
                }
                .stroke(c, lineWidth: 1.8)
            }
        }
    }
}

#Preview {
    MainTabView()
}
