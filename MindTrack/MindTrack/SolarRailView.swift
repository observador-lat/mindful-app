import SwiftUI

struct SolarRailView: View {
    var isNight: Bool
    
    var body: some View {
        VStack {
            Image(systemName: isNight ? "moon.stars.fill" : "sun.max.fill")
                .font(.largeTitle)
                .foregroundColor(isNight ? .white : .yellow)
            Rectangle()
                .frame(width: 2, height: 100)
                .foregroundColor(.clear)
                .overlay(
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(isNight ? .gray : .orange)
                )
        }
    }
}

#Preview {
    SolarRailView(isNight: false)
}
