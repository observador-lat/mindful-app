import SwiftUI

struct BottomBar: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                tabItem(systemName: "tray", title: "Tray")
                Spacer()
                tabItem(systemName: "timeline", title: "Timeline")
                Spacer()
                tabItem(systemName: "brain", title: "Brain")
                Spacer()
                tabItem(systemName: "gearshape", title: "Settings")
            }
            .frame(height: 88)
            .background(Color(hex: "E8A13A").opacity(0.35))
            .frame(maxWidth: .infinity)

            fab
        }
    }

    private func tabItem(systemName: String, title: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: systemName)
                .font(.system(size: 22))
            Text(title)
                .font(.system(size: 12, weight: .semibold))
        }
    }

    private var fab: some View {
        ZStack {
            Circle()
                .stroke(Color(hex: "E8A13A"), lineWidth: 2)
                .frame(width: 100, height: 100)
                .background(Circle().fill(Color(hex: "E8A13A").opacity(0.35)))

            Circle()
                .stroke(Color(hex: "E8A13A"), lineWidth: 2)
                .frame(width: 74, height: 74)
                .background(Circle().fill(Color(hex: "E8A13A").opacity(0.55)))

            Circle()
                .stroke(Color(hex: "E8A13A"), lineWidth: 2)
                .frame(width: 44, height: 44)
                .background(Circle().fill(Color(hex: "E8A13A")))

            Text("focus")
                .font(.system(size: 16, weight: .heavy))
                .foregroundColor(Color(hex: "E8674D"))
        }
        .offset(y: -44)
    }
}

extension Color {
    init(hex: String) {
        var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
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

#Preview {
    BottomBar()
}
