import SwiftUI
import Charts

enum ApercuSubTab: String, CaseIterable {
    case apercu   = "Aperçu"
    case depenses = "Dépenses"
    case liste    = "Liste"
}

struct ApercuView: View {
    @State private var selectedSubTab: ApercuSubTab = .apercu

    // Design colors matching prototype
    private let darkText   = Color(hex: "#0F1923")!
    private let midGray    = Color(hex: "#6B7A99")!
    private let surface    = Color(hex: "#F5F7FA")!
    private let chipBlue   = Color(hex: "#EDF2FA")!
    private let separator  = Color(hex: "#F2F4F8")!

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                // Scrollable content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        topBar
                        balanceSection
                        statsChips
                        segmentedControl
                            .padding(.horizontal, 18)
                            .padding(.bottom, 16)

                        switch selectedSubTab {
                        case .apercu:   apercuContent
                        case .depenses: depensesContent
                        case .liste:    listeContent
                        }
                    }
                }
            }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            HStack(spacing: 10) {
                ZStack {
                    Circle().fill(Color.evoNavy).frame(width: 40, height: 40)
                    Text("A")
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading, spacing: 1) {
                    Text("Bonjour, Alex")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(midGray)
                    Text("Bon retour ! 👋")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(darkText)
                }
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.evoNavy.opacity(0.1), radius: 8, x: 0, y: 2)
                    .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 1))
                Text("🔔").font(.system(size: 17))
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 52)
        .padding(.bottom, 22)
    }

    // MARK: - Balance

    private var balanceSection: some View {
        VStack(spacing: 5) {
            Text("SOLDE DISPONIBLE")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(midGray)
                .kerning(1.5)
            Text("3 247 €")
                .font(.system(size: 42, weight: .black))
                .foregroundColor(darkText)
                .kerning(-2)
        }
        .padding(.bottom, 18)
    }

    // MARK: - Stats Chips

    private var statsChips: some View {
        HStack(spacing: 10) {
            statChip(
                icon: "↑", iconBg: Color(hex: "#22C47A")!.opacity(0.12), iconColor: .evoGreen,
                label: "Revenus", value: "+2 800 €"
            )
            statChip(
                icon: "↓", iconBg: Color(hex: "#FF4E6A")!.opacity(0.10), iconColor: .evoRed,
                label: "Dépenses", value: "-547 €"
            )
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 18)
    }

    private func statChip(icon: String, iconBg: Color, iconColor: Color, label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5).fill(iconBg).frame(width: 18, height: 18)
                    Text(icon).font(.system(size: 10, weight: .bold)).foregroundColor(iconColor)
                }
                Text(label.uppercased())
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(Color(hex: "#6B7A99")!)
                    .kerning(0.5)
            }
            Text(value)
                .font(.system(size: 16, weight: .black))
                .foregroundColor(darkText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.82))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.55), lineWidth: 1))
        .shadow(color: Color.evoNavy.opacity(0.07), radius: 8, x: 0, y: 2)
    }

    // MARK: - Segmented Control

    private var segmentedControl: some View {
        HStack(spacing: 0) {
            ForEach(ApercuSubTab.allCases, id: \.self) { tab in
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

    // MARK: - Aperçu Content

    private var apercuContent: some View {
        VStack(spacing: 12) {
            lineChartCard
            comptesConnectesSection
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 16)
    }

    private var lineChartCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("DÉPENSES CE MOIS")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.evoGray)
                        .kerning(0.5)
                    Text("547 €")
                        .font(.system(size: 22, weight: .black))
                        .foregroundColor(darkText)
                        .kerning(-0.5)
                }
                Spacer()
                HStack(spacing: 4) {
                    Text("↓").font(.system(size: 11)).foregroundColor(.evoGreen)
                    Text("-8%").font(.system(size: 11, weight: .bold)).foregroundColor(.evoGreen)
                }
                .padding(.horizontal, 10).padding(.vertical, 5)
                .background(Color(hex: "#E8F5EE")!).cornerRadius(20)
            }
            .padding(.bottom, 12)

            LineChartView()
                .frame(height: 54)

            HStack {
                Text("1 juin")
                    .font(.system(size: 10)).foregroundColor(Color(hex: "#C0CCDD")!)
                Spacer()
                Text("Aujourd'hui")
                    .font(.system(size: 10, weight: .bold)).foregroundColor(Color.evoNavy)
            }
            .padding(.top, 4)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.evoNavy.opacity(0.08), radius: 16, x: 0, y: 4)
    }

    private var comptesConnectesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Comptes connectés")
                    .font(.system(size: 14, weight: .black))
                    .foregroundColor(darkText)
                Spacer()
                Text("+ Ajouter")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.evoNavy)
                    .padding(.horizontal, 10).padding(.vertical, 4)
                    .background(Color.evoNavy.opacity(0.07)).cornerRadius(20)
            }
            .padding(.bottom, 10)

            let accounts: [(String, Color, String, String)] = [
                ("🏦", Color(hex: "#EDF2FA")!, "Compte courant", "Connecter"),
                ("💳", Color(hex: "#FF4E6A")!.opacity(0.07), "Carte bleue", "Connecter"),
                ("🐷", Color(hex: "#EDFAF3")!, "Épargne", "Connecter"),
            ]
            ForEach(Array(accounts.enumerated()), id: \.offset) { _, item in
                HStack(spacing: 11) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 11).fill(item.1).frame(width: 36, height: 36)
                        Text(item.0).font(.system(size: 17))
                    }
                    VStack(alignment: .leading, spacing: 1) {
                        Text(item.2).font(.system(size: 13, weight: .bold)).foregroundColor(darkText)
                        Text(item.3).font(.system(size: 11)).foregroundColor(.evoGray)
                    }
                    Spacer()
                    Text("›").font(.system(size: 18)).foregroundColor(Color(hex: "#C8D0DC")!)
                }
                .padding(.horizontal, 14).padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.evoNavy.opacity(0.06), radius: 8, x: 0, y: 2)
                .padding(.bottom, 8)
            }
        }
    }

    // MARK: - Dépenses Content

    private var depensesContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("AUJOURD'HUI")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(hex: "#6B7A99")!)
                .kerning(1)
                .padding(.bottom, 10)

            let recent = MockData.transactions.filter { $0.day >= 24 }
            ForEach(recent) { txn in txnRow(txn) }

            Text("CETTE SEMAINE")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(hex: "#6B7A99")!)
                .kerning(1)
                .padding(.top, 8).padding(.bottom, 10)

            let older = MockData.transactions.filter { $0.day < 24 && $0.day >= 18 }
            ForEach(older) { txn in txnRow(txn) }
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 16)
    }

    // MARK: - Liste Content

    private var listeContent: some View {
        VStack(spacing: 0) {
            ForEach(Array(MockData.spendingByCategory.enumerated()), id: \.offset) { idx, cat in
                HStack(spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 9)
                            .fill(cat.icon == "💰" ? Color(hex: "#EDFAF3")! : Color(hex: "#EDF2FA")!)
                            .frame(width: 30, height: 30)
                        Text(cat.icon).font(.system(size: 13))
                    }
                    Text(cat.name)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(darkText)
                    Spacer()
                    Text(cat.icon == "💰" ? "+\(cat.total.formatted())" : "-\(cat.total.formatted())")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(cat.color)
                }
                .padding(.horizontal, 16).padding(.vertical, 14)
                if idx < MockData.spendingByCategory.count - 1 {
                    Divider().padding(.leading, 56)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.evoNavy.opacity(0.08), radius: 16, x: 0, y: 4)
        .padding(.horizontal, 18)
        .padding(.bottom, 16)
    }

    // MARK: - Transaction Row

    private func txnRow(_ txn: MockTransaction) -> some View {
        HStack(spacing: 11) {
            ZStack {
                RoundedRectangle(cornerRadius: 11).fill(txn.iconBackground).frame(width: 36, height: 36)
                Text(txn.icon).font(.system(size: 17))
            }
            VStack(alignment: .leading, spacing: 1) {
                Text(txn.title).font(.system(size: 13, weight: .bold)).foregroundColor(Color(hex: "#0F1923")!)
                Text("\(txn.category) · \(txn.hour)").font(.system(size: 11)).foregroundColor(.evoGray)
            }
            Spacer()
            Text(txn.isRevenu ? "+\(txn.amount.formatted())" : "-\(abs(txn.amount).formatted())")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(txn.isRevenu ? .evoGreen : .evoRed)
        }
        .padding(.horizontal, 14).padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.evoNavy.opacity(0.06), radius: 8, x: 0, y: 2)
        .padding(.bottom, 8)
    }
}

// MARK: - Line Chart View

struct LineChartView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack(alignment: .topLeading) {
                // Gradient fill
                Path { p in
                    p.move(to: CGPoint(x: 0, y: h * 0.89))
                    p.addCurve(to: CGPoint(x: w * 0.4, y: h * 0.54),
                               control1: CGPoint(x: w * 0.13, y: h * 0.83),
                               control2: CGPoint(x: w * 0.27, y: h * 0.67))
                    p.addCurve(to: CGPoint(x: w * 0.7, y: h * 0.33),
                               control1: CGPoint(x: w * 0.53, y: h * 0.41),
                               control2: CGPoint(x: w * 0.6, y: h * 0.48))
                    p.addLine(to: CGPoint(x: w * 0.7, y: h))
                    p.addLine(to: CGPoint(x: 0, y: h))
                    p.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        colors: [Color.evoNavy.opacity(0.14), Color.evoNavy.opacity(0)],
                        startPoint: .top, endPoint: .bottom
                    )
                )

                // Solid line (history)
                Path { p in
                    p.move(to: CGPoint(x: 0, y: h * 0.89))
                    p.addCurve(to: CGPoint(x: w * 0.4, y: h * 0.54),
                               control1: CGPoint(x: w * 0.13, y: h * 0.83),
                               control2: CGPoint(x: w * 0.27, y: h * 0.67))
                    p.addCurve(to: CGPoint(x: w * 0.7, y: h * 0.33),
                               control1: CGPoint(x: w * 0.53, y: h * 0.41),
                               control2: CGPoint(x: w * 0.6, y: h * 0.48))
                }
                .stroke(Color.evoNavy, style: StrokeStyle(lineWidth: 2.5, lineCap: .round))

                // Dashed forecast line
                Path { p in
                    p.move(to: CGPoint(x: w * 0.7, y: h * 0.33))
                    p.addCurve(to: CGPoint(x: w, y: h * 0.28),
                               control1: CGPoint(x: w * 0.83, y: h * 0.26),
                               control2: CGPoint(x: w * 0.87, y: h * 0.26))
                }
                .stroke(Color(hex: "#CBD5E4")!, style: StrokeStyle(lineWidth: 2, dash: [5, 4], lineCap: .round))

                // Today dot
                ZStack {
                    Circle()
                        .fill(Color.evoNavy.opacity(0.12))
                        .frame(width: 18, height: 18)
                    Circle()
                        .fill(Color.evoNavy)
                        .frame(width: 9, height: 9)
                }
                .position(x: w * 0.7, y: h * 0.33)
            }
        }
    }
}

#Preview {
    ApercuView()
}
