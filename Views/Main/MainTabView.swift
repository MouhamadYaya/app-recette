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

// MARK: - Bump Shape

struct TabBarBumpShape: Shape {
    var cornerRadius: CGFloat = 30
    var bumpRadius: CGFloat   = 36
    var bumpProtrusion: CGFloat = 20   // how far the bump rises above bar top

    func path(in rect: CGRect) -> Path {
        let cx      = rect.midX
        let barTop  = rect.minY + bumpProtrusion  // flat bar starts here
        let bottom  = rect.maxY
        let left    = rect.minX
        let right   = rect.maxX
        let r       = cornerRadius
        let br      = bumpRadius

        // Bump circle center (sits bumpProtrusion below the very top of the frame)
        let bumpCY  = barTop + br - bumpProtrusion   // = rect.minY + br

        // Intersection points of bump circle with barTop horizontal line
        let dy = barTop - bumpCY
        let dx = sqrt(max(0, br * br - dy * dy))
        let bumpLeft  = cx - dx
        let bumpRight = cx + dx

        // Angles from bump center to intersection points (math convention, y-up)
        let startAngle = Angle(radians: atan2(Double(barTop - bumpCY), Double(bumpLeft  - cx)))
        let endAngle   = Angle(radians: atan2(Double(barTop - bumpCY), Double(bumpRight - cx)))

        var path = Path()

        // ── Top-left corner ──────────────────────────────────────────────────
        path.move(to: CGPoint(x: left + r, y: barTop))
        path.addArc(center: CGPoint(x: left + r, y: barTop + r), radius: r,
                    startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
        // Left edge
        path.addLine(to: CGPoint(x: left, y: bottom - r))
        // Bottom-left corner
        path.addArc(center: CGPoint(x: left + r, y: bottom - r), radius: r,
                    startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
        // Bottom edge
        path.addLine(to: CGPoint(x: right - r, y: bottom))
        // Bottom-right corner
        path.addArc(center: CGPoint(x: right - r, y: bottom - r), radius: r,
                    startAngle: .degrees(90), endAngle: .degrees(0), clockwise: true)
        // Right edge
        path.addLine(to: CGPoint(x: right, y: barTop + r))
        // Top-right corner
        path.addArc(center: CGPoint(x: right - r, y: barTop + r), radius: r,
                    startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true)
        // Top edge right → bump right
        path.addLine(to: CGPoint(x: bumpRight, y: barTop))
        // Bump arc — goes up and over (counterclockwise in screen = clockwise: false)
        path.addArc(center: CGPoint(x: cx, y: bumpCY), radius: br,
                    startAngle: endAngle, endAngle: startAngle, clockwise: false)
        // Top edge bump left → top-left
        path.addLine(to: CGPoint(x: left + r, y: barTop))
        path.closeSubpath()

        return path
    }
}

// MARK: - Main Tab View

struct MainTabView: View {
    @State private var selectedTab: MainTab = .apercu
    @State private var showAddExpense = false

    private let bumpProtrusion: CGFloat = 18
    private let bumpRadius: CGFloat     = 38
    private let barHeight: CGFloat      = 64

    var body: some View {
        ZStack(alignment: .bottom) {
            // Screen content — leaves room for bar + bump
            Group {
                switch selectedTab {
                case .apercu:     ApercuView()
                case .budget:     BudgetView()
                case .calendrier: CalendrierView()
                case .parametres: ParametresView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, barHeight + 20)

            // Floating nav
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

    private var floatingNav: some View {
        ZStack(alignment: .top) {
            // Unified bump shape — one piece, no seams
            TabBarBumpShape(cornerRadius: 30, bumpRadius: bumpRadius, bumpProtrusion: bumpProtrusion)
                .fill(Color.evoNavy)
                .frame(height: barHeight + bumpProtrusion)
                .shadow(color: Color.evoNavy.opacity(0.38), radius: 22, x: 0, y: 10)
                .shadow(color: Color.evoNavy.opacity(0.12), radius: 6,  x: 0, y: 2)

            // Tab items + center button — all inside the same container
            HStack(spacing: 0) {
                navItem(.apercu)
                navItem(.budget)

                // Center — + nested inside the bump, no extra background
                Button { showAddExpense = true } label: {
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.22), lineWidth: 1.5)
                            .frame(width: 40, height: 40)
                        Image(systemName: "plus")
                            .font(.system(size: 23, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                .frame(width: bumpRadius * 2)
                .offset(y: -19)

                navItem(.calendrier)
                navItem(.parametres)
            }
            .padding(.horizontal, 10)
            .frame(height: barHeight + bumpProtrusion)
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
                    .font(.system(size: 9, weight: isActive ? .bold : .medium))
                    .foregroundColor(isActive ? .white : Color.white.opacity(0.4))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .padding(.top, bumpProtrusion)
        }
    }

    @ViewBuilder
    private func navIcon(_ tab: MainTab, active: Bool) -> some View {
        let c = active ? Color.white : Color.white.opacity(0.4)
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
