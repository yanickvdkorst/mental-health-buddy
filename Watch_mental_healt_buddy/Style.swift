import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Style {
    struct Text {
        static let title1 = Font.system(size: 28, weight: .bold, design: .default)
        static let title3 = Font.system(size: 20, weight: .regular, design: .default)
        static let headline = Font.system(size: 24, weight: .regular, design: .default)
        static let body = Font.system(size: 17, weight: .regular, design: .default)
        static let subheadline = Font.system(size: 15, weight: .regular, design: .default)
        static let cardText = Font.system(size: 16, weight: .regular, design: .default)
    }

    struct StyleColor {
           static let primary = Color(hex: "#F9F9F6")
           static let secondary = Color(hex: "#0000FF")
           static let accent = Color(hex: "#FFADAD")
           static let white = Color(hex: "#FFFFFF")
           static let black = Color(hex: "#000000")
           static let textPrimary = Color(hex: "#2E2E2E")
           static let textSecondary = Color(hex: "#5B5B5B")
           static let textThird = Color(hex: "#5B5B5B")
           static let background = Color(hex: "#F5F5F5")
           static let border = Color(hex: "#E4E4E4")
    }
}
