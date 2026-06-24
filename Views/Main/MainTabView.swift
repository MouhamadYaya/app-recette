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

    // Layout constants
    private let barH:    CGFloat = 64
    private let bumpD:   CGFloat = 58   // bump circle diameter
    private let protrude: CGFloat = 12  // how much the bump rises above bar top

    var body: some View {
        ZStack(alignment: .bottom) {
            // Full-screen gradient so safe area behind nav stays blue, never white
            LinearGradient.evoBackground.ignoresSafeArea()

            // Page content
            Group {
                switch selectedTab {
                case .apercu:     ApercuView()
                case .budget:     BudgetView()
                case .calendrier: CalendrierView()
                case .parametres: ParametresView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, barH + 24)

            // Floating nav (truly floats — no background container)
            floatingNav
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

    // MARK: - Floating Nav
    //
    // Two shapes, same Color.evoNavy → they fuse into one piece visually.
    // The circle is drawn FIRST (behind the bar), the bar covers its bottom
    // half, only the top `protrude` pixels stick out above the bar.

    private var floatingNav: some View {
        ZStack(alignment: .bottom) {

            // ① Bump circle — same navy as bar → seamless visual merge
            Circle()
                .fill(Color.evoNavy)
                .frame(width: bumpD, height: bumpD)
                .overlay(Circle().stroke(Color.white.opacity(0.18), lineWidth: 1.5))
                // Dark halo shadow around the circle (visible on the navy bar behind it)
                // = the subtle depth ring seen on the competitor image
                .shadow(color: Color.black.opacity(0.30), radius: 10, x: 0, y: 0)
                .offset(y: -(barH - bumpD + protrude))  // = -(64 - 58 + 12) = -18

            // ② Bar — the main pill, covers the bump circle's lower half
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.evoNavy)
                .frame(height: barH)
                .shadow(color: Color.evoNavy.opacity(0.40), radius: 22, x: 0, y: 10)
                .shadow(color: Color.evoNavy.opacity(0.12), radius: 5,  x: 0, y: 2)

            // ③ Tab items — 5 items in one even row
            HStack(spacing: 0) {
                tabItem(.apercu)
                tabItem(.budget)
                plusItem
                tabItem(.calendrier)
                tabItem(.parametres)
            }
            .padding(.horizontal, 4)
            .frame(height: barH)
        }
    }

    // MARK: - Plus Button (center)

    private var plusItem: some View {
        // Circle center is at barH/2 - protrude above bar center = 15px higher than bar center.
        // Apply offset(y: -15) so the icon aligns exactly with the circle center.
        let iconOffset: CGFloat = -(barH / 2 + protrude - bumpD / 2)  // = -15
        return Button { showAddExpense = true } label: {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.white)
                .offset(y: iconOffset)
                .frame(maxWidth: .infinity)
                .frame(height: barH)
                .contentShape(Rectangle())
        }
    }

    // MARK: - Tab Item

    @ViewBuilder
    private func tabItem(_ tab: MainTab) -> some View {
        let active = selectedTab == tab
        Button { selectedTab = tab } label: {
            VStack(spacing: 4) {
                tabIcon(tab, active: active)
                    .frame(width: 22, height: 22)
                Text(tab.label)
                    .font(.system(size: 9, weight: active ? .bold : .medium))
                    .foregroundColor(active ? .white : Color.white.opacity(0.45))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .frame(height: barH)
            .contentShape(Rectangle())
        }
    }

    // MARK: - Icons

    @ViewBuilder
    private func tabIcon(_ tab: MainTab, active: Bool) -> some View {
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
                        HStack {
                            RoundedRectangle(cornerRadius: 1).fill(c).frame(width: 8, height: 1.5)
                            Spacer()
                        }
                        RoundedRectangle(cornerRadius: 1).fill(c).frame(height: 1.5)
                    }
                    .padding(.horizontal, 4)
                    .padding(.vertical, 4)
                )
        case .calendrier:
            Image(systemName: "calendar")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(c)
        case .parametres:
            ZStack {
                Circle()
                    .stroke(c, lineWidth: 1.8)
                    .frame(width: 8, height: 8)
                    .offset(y: -4)
                Path { p in
                    p.addArc(center: CGPoint(x: 10, y: 20), radius: 7,
                             startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
                }
                .stroke(c, lineWidth: 1.8)
            }
        }
    }
}

#Preview {
    MainTabView()
}
