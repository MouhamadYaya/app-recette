import SwiftUI

struct CalendrierView: View {
    @State private var selectedDay: Int? = nil

    private let year  = 2026
    private let month = 6
    private let monthName = "Juin 2026"

    // June 2026 starts on a Monday (weekday index 0 in Mon-based grid)
    private let startWeekday = 0
    private let daysInMonth  = 30

    private let weekdays = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"]

    var body: some View {
        ZStack {
            LinearGradient.evoBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                calendarHeader
                calendarGrid
                    .padding(.horizontal, 16)

                Divider()
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)

                transactionList
            }
        }
    }

    // MARK: - Header

    private var calendarHeader: some View {
        VStack(spacing: 4) {
            Text(monthName)
                .font(.system(size: 24, weight: .black))
                .foregroundColor(.evoNavy)
                .padding(.top, 56)
                .padding(.bottom, 16)
        }
    }

    // MARK: - Grid

    private var calendarGrid: some View {
        VStack(spacing: 0) {
            // Weekday labels
            HStack(spacing: 0) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.evoGray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 8)

            // Day cells
            let cells = startWeekday + daysInMonth
            let rows  = Int(ceil(Double(cells) / 7.0))

            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { col in
                        let index = row * 7 + col
                        let day   = index - startWeekday + 1
                        if index < startWeekday || day > daysInMonth {
                            Color.clear.frame(maxWidth: .infinity).frame(height: 52)
                        } else {
                            dayCell(day: day)
                        }
                    }
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.evoNavy.opacity(0.08), radius: 12, x: 0, y: 4)
    }

    @ViewBuilder
    private func dayCell(day: Int) -> some View {
        let isSelected = selectedDay == day
        let txns       = MockData.transactions(forDay: day)
        let hasRevenu  = txns.contains { $0.isRevenu }
        let hasDepense = txns.contains { !$0.isRevenu }
        let isToday    = day == 24  // simulate today = June 24 2026

        Button {
            selectedDay = (selectedDay == day) ? nil : day
        } label: {
            VStack(spacing: 3) {
                Text("\(day)")
                    .font(.system(size: 14, weight: isToday ? .black : .regular))
                    .foregroundColor(isSelected ? .white : (isToday ? .evoNavy : .evoDarkText))
                    .frame(width: 32, height: 32)
                    .background(isSelected ? Color.evoNavy : Color.clear)
                    .clipShape(Circle())

                HStack(spacing: 3) {
                    if hasRevenu  { Circle().fill(Color.evoGreen).frame(width: 5, height: 5) }
                    if hasDepense { Circle().fill(Color.evoRed).frame(width: 5, height: 5) }
                    if !hasRevenu && !hasDepense { Color.clear.frame(width: 5, height: 5) }
                }
                .frame(height: 6)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
        }
    }

    // MARK: - Transaction List

    @ViewBuilder
    private var transactionList: some View {
        if let day = selectedDay {
            let txns = MockData.transactions(forDay: day)
            VStack(alignment: .leading, spacing: 12) {
                Text("Transactions du \(day) juin")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.evoNavy)
                    .padding(.horizontal, 20)

                if txns.isEmpty {
                    Text("Aucune transaction ce jour.")
                        .font(.system(size: 14))
                        .foregroundColor(.evoGray)
                        .padding(.horizontal, 20)
                } else {
                    ForEach(txns) { txn in
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

                            Text(txn.isRevenu ? "+\(txn.amount.formatted())" : "-\(abs(txn.amount).formatted())")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(txn.isRevenu ? .evoGreen : .evoRed)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .padding(.bottom, 16)
        } else {
            VStack(spacing: 8) {
                Image(systemName: "calendar.badge.clock")
                    .font(.system(size: 32))
                    .foregroundColor(.evoGray.opacity(0.5))
                Text("Sélectionnez un jour")
                    .font(.system(size: 14))
                    .foregroundColor(.evoGray)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 16)
        }
    }
}

#Preview {
    CalendrierView()
}
