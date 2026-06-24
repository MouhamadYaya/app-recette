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

            // Floating pill nav
            floatingNav
                .padding(.horizontal, 14)
                .padding(.bottom, 20)
        }
        .ignoresSafeArea(edges: .bottom)
    }

    // MARK: - Floating Nav

    private var floatingNav: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                Button { selectedTab = tab } label: {
                    navItem(tab)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.white.opacity(0.92))
                .shadow(color: Color.evoNavy.opacity(0.14), radius: 20, x: 0, y: 8)
                .shadow(color: Color.evoNavy.opacity(0.08), radius: 6, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                )
        )
    }

    @ViewBuilder
    private func navItem(_ tab: MainTab) -> some View {
        let isActive = selectedTab == tab
        VStack(spacing: 2) {
            navIcon(tab, active: isActive)
                .frame(width: 20, height: 20)
            Text(tab.label)
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(isActive ? .white : .evoGray)
                .lineLimit(1)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 6)
        .background(isActive ? Color.evoNavy : Color.clear)
        .cornerRadius(22)
    }

    @ViewBuilder
    private func navIcon(_ tab: MainTab, active: Bool) -> some View {
        let c = active ? Color.white : Color.evoGray
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
