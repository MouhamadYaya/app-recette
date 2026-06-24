import SwiftUI

struct CalendrierView: View {
    @State private var selectedDay: Int? = nil

    // June 2026 starts Monday (index 0)
    private let startWeekday  = 0
    private let daysInMonth   = 30
    private let weekdayLabels = ["L", "M", "M", "J", "V", "S", "D"]
    private let weekendIdxs   = Set([5, 6])

    private let darkText = Color(hex: "#0F1923")!
    private let midGray  = Color(hex: "#6B7A99")!

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        calendarCard
                        transactionCard
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 16)
                }
            }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 38, height: 38)
                    .shadow(color: Color.evoNavy.opacity(0.09), radius: 6, x: 0, y: 2)
                    .overlay(Circle().stroke(Color.white.opacity(0.5), lineWidth: 1))
                Text("‹").font(.system(size: 20)).foregroundColor(darkText)
            }
            Spacer()
            VStack(spacing: 1) {
                Text("CALENDRIER")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(midGray)
                    .kerning(1)
                Text("Juin 2026")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(darkText)
                    .kerning(-0.5)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 38, height: 38)
                    .shadow(color: Color.evoNavy.opacity(0.09), radius: 6, x: 0, y: 2)
                    .overlay(Circle().stroke(Color.white.opacity(0.5), lineWidth: 1))
                Text("›").font(.system(size: 20)).foregroundColor(darkText)
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 16)
        .padding(.bottom, 14)
    }

    // MARK: - Calendar Card

    private var calendarCard: some View {
        VStack(spacing: 0) {
            // Weekday headers
            HStack(spacing: 0) {
                ForEach(Array(weekdayLabels.enumerated()), id: \.offset) { idx, label in
                    Text(label)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(weekendIdxs.contains(idx) ? Color(hex: "#5A7CB0")! : .evoGray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 3)
                }
            }
            .padding(.bottom, 6)

            // Day grid
            let totalCells = startWeekday + daysInMonth
            let rows = Int(ceil(Double(totalCells) / 7.0))

            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 3) {
                    ForEach(0..<7, id: \.self) { col in
                        let index = row * 7 + col
                        let day   = index - startWeekday + 1
                        if index < startWeekday || day > daysInMonth {
                            Color.clear.frame(maxWidth: .infinity).frame(height: 42)
                        } else {
                            dayCell(day: day)
                        }
                    }
                }
            }

            // Legend
            HStack(spacing: 16) {
                Spacer()
                legendItem(color: .evoGreen, label: "Revenus")
                legendItem(color: .evoRed, label: "Dépenses")
                Spacer()
            }
            .padding(.top, 10)
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.evoNavy.opacity(0.08), radius: 16, x: 0, y: 4)
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: 5) {
            Circle().fill(color).frame(width: 7, height: 7)
            Text(label).font(.system(size: 10)).foregroundColor(midGray)
        }
    }

    @ViewBuilder
    private func dayCell(day: Int) -> some View {
        let isSelected = selectedDay == day
        let txns       = MockData.transactions(forDay: day)
        let hasRevenu  = txns.contains { $0.isRevenu }
        let hasDepense = txns.contains { !$0.isRevenu }
        let isToday    = day == 24

        Button {
            selectedDay = (selectedDay == day) ? nil : day
        } label: {
            VStack(spacing: 2) {
                Text("\(day)")
                    .font(.system(size: 12, weight: isToday ? .black : .regular))
                    .foregroundColor(isSelected ? .white : (isToday ? Color.evoNavy : darkText))
                    .frame(maxWidth: .infinity)
                    .frame(height: 24)

                HStack(spacing: 2) {
                    Circle()
                        .fill(hasRevenu ? Color.evoGreen : Color.clear)
                        .frame(width: 4, height: 4)
                    Circle()
                        .fill(hasDepense ? Color.evoRed : Color.clear)
                        .frame(width: 4, height: 4)
                }
                .frame(height: 6)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 2)
            .background(isSelected ? Color.evoNavy : Color.clear)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
            .frame(height: 42)
        }
    }

    // MARK: - Transaction Card

    @ViewBuilder
    private var transactionCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            let label: String = {
                guard let day = selectedDay else { return "Sélectionnez un jour" }
                return "\(day) juin 2026"
            }()
            let txns = selectedDay.map { MockData.transactions(forDay: $0) } ?? []

            Text(label)
                .font(.system(size: 12, weight: .black))
                .foregroundColor(Color.evoNavy)
                .padding(.bottom, 10)

            if let _ = selectedDay, txns.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 6) {
                        Image(systemName: "tray")
                            .font(.system(size: 24))
                            .foregroundColor(.evoGray.opacity(0.4))
                        Text("Aucune transaction")
                            .font(.system(size: 13))
                            .foregroundColor(.evoGray)
                    }
                    Spacer()
                }
                .padding(.vertical, 20)
            } else if selectedDay == nil {
                HStack {
                    Spacer()
                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 28))
                        .foregroundColor(.evoGray.opacity(0.35))
                    Spacer()
                }
                .padding(.vertical, 20)
            } else {
                VStack(spacing: 8) {
                    ForEach(txns) { txn in
                        HStack(spacing: 10) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 11)
                                    .fill(Color(hex: "#F5F7FA")!)
                                    .frame(width: 36, height: 36)
                                Text(txn.icon).font(.system(size: 18))
                            }
                            VStack(alignment: .leading, spacing: 1) {
                                Text(txn.title)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(darkText)
                                Text("\(txn.hour)")
                                    .font(.system(size: 11))
                                    .foregroundColor(.evoGray)
                            }
                            Spacer()
                            Text(txn.isRevenu ? "+\(txn.amount.formatted())" : "-\(abs(txn.amount).formatted())")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(txn.isRevenu ? .evoGreen : .evoRed)
                        }
                        .padding(10)
                        .background(Color(hex: "#F5F7FA")!)
                        .cornerRadius(13)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.evoNavy.opacity(0.08), radius: 16, x: 0, y: 4)
    }
}

#Preview {
    CalendrierView()
}
