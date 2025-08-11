import SwiftUI

struct WeekDay: Identifiable {
    let id = UUID()
    let abbreviation: String
    let day: String
}

struct WeekSelector: View {
    let weekDays: [WeekDay]
    @State private var selectedId: UUID?

    var body: some View {
        HStack(spacing: 14) {
            ForEach(weekDays) { day in
                Button {
                    selectedId = day.id
                } label: {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(selectedId == day.id ? Color(hex: "E8674D") : Color(hex: "F5ECE9"))
                        .frame(width: 88, height: 84)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        .overlay(
                            VStack {
                                Text(day.abbreviation)
                                    .font(.system(size: 14, weight: .medium))
                                Text(day.day)
                                    .font(.system(size: 22, weight: .bold))
                            }
                            .foregroundColor(.black)
                        )
                }
            }
        }
    }
}

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

#Preview {
    WeekSelector(weekDays: [
        WeekDay(abbreviation: "Mon", day: "7"),
        WeekDay(abbreviation: "Tue", day: "8"),
        WeekDay(abbreviation: "Wed", day: "9"),
        WeekDay(abbreviation: "Thu", day: "10"),
        WeekDay(abbreviation: "Fri", day: "11"),
        WeekDay(abbreviation: "Sat", day: "12"),
        WeekDay(abbreviation: "Sun", day: "13")
    ])
}
