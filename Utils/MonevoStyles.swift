import SwiftUI

// MARK: - Couleurs Monevo

extension Color {
    static let evoNavy      = Color(hex: "#18284A")!
    static let evoBlue      = Color(hex: "#C2D8ED")!
    static let evoGreen     = Color(hex: "#22C47A")!
    static let evoRed       = Color(hex: "#FF4E6A")!
    static let evoGray      = Color(hex: "#8A94A6")!
    static let evoLightGray = Color(hex: "#F2F4F8")!
    static let evoDarkText  = Color(hex: "#0F1923")!
    static let evoBackground = Color(hex: "#C2D8ED")!
}

// MARK: - Gradients

extension LinearGradient {
    static let evoBackground = LinearGradient(
        colors: [
            Color(hex: "#EEF5FC")!,
            Color(hex: "#E4EFF9")!,
            Color(hex: "#F0F6FD")!,
            Color(hex: "#E8F2FB")!,
            Color(hex: "#DDE9F6")!,
        ],
        startPoint: UnitPoint(x: 0.0, y: 0.0),
        endPoint: UnitPoint(x: 1.0, y: 1.0)
    )
}

// MARK: - Bouton principal Monevo

struct MonevoPrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.evoNavy)
            .cornerRadius(16)
            .shadow(color: Color.evoNavy.opacity(0.25), radius: 8, x: 0, y: 4)
    }
}

extension View {
    func evoButtonStyle() -> some View {
        self.modifier(MonevoPrimaryButton())
    }
}

// MARK: - Card Monevo

struct MonevoCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.evoNavy.opacity(0.08), radius: 12, x: 0, y: 4)
    }
}

extension View {
    func evoCard() -> some View {
        self.modifier(MonevoCard())
    }
}

// MARK: - Logo Monevo

struct MonevoLogo: View {
    var size: CGFloat = 40

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.25)
                .fill(Color.evoNavy)
                .frame(width: size, height: size)

            Image(systemName: "dollarsign.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: size * 0.55, height: size * 0.55)
        }
    }
}

// MARK: - Fond principal

extension View {
    func evoBackground() -> some View {
        self.background(LinearGradient.evoBackground.ignoresSafeArea())
    }
}

// MARK: - Extensions utilitaires

extension Color {
    init?(hex: String) {
        var hexStr = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexStr = hexStr.hasPrefix("#") ? String(hexStr.dropFirst()) : hexStr

        guard hexStr.count == 6,
              let value = UInt64(hexStr, radix: 16) else { return nil }

        self.init(
            red:   Double((value >> 16) & 0xFF) / 255,
            green: Double((value >> 8)  & 0xFF) / 255,
            blue:  Double(value         & 0xFF) / 255
        )
    }
}

extension Double {
    func formatted(currency: String = "€") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        let number = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return "\(number) \(currency)"
    }
}
