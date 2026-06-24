import SwiftUI

enum MainTab: String, CaseIterable {
    case apercu     = "Aperçu"
    case budget     = "Budget"
    case calendrier = "Calendrier"
    case parametres = "Paramètres"

    var icon: String {
        switch self {
        case .apercu:     return "chart.pie.fill"
        case .budget:     return "creditcard.fill"
        case .calendrier: return "calendar"
        case .parametres: return "gearshape.fill"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .apercu

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .apercu:     ApercuView()
                case .budget:     BudgetView()
                case .calendrier: CalendrierView()
                case .parametres: ParametresView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 80)

            tabBar
        }
        .ignoresSafeArea(edges: .bottom)
    }

    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    tabItem(tab)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .padding(.bottom, 20)
        .background(Color.white)
        .shadow(color: Color.evoNavy.opacity(0.08), radius: 16, x: 0, y: -4)
    }

    @ViewBuilder
    private func tabItem(_ tab: MainTab) -> some View {
        let isSelected = selectedTab == tab
        VStack(spacing: 4) {
            Image(systemName: tab.icon)
                .font(.system(size: 18, weight: .semibold))
            Text(tab.rawValue)
                .font(.system(size: 10, weight: .medium))
        }
        .foregroundColor(isSelected ? .white : .evoGray)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? Color.evoNavy : Color.clear)
        .cornerRadius(12)
    }
}

#Preview {
    MainTabView()
}
