import SwiftUI

struct SolarRailView: View {
    var topY: CGFloat
    var bottomY: CGFloat
    var currentY: CGFloat
    var isNight: Bool
    var day: Date

    private var markerRadius: CGFloat { 14 }
    private var railColor: Color {
        isNight ? Color(red: 0.03, green: 0.45, blue: 0.71) : Color(red: 232/255, green: 161/255, blue: 58/255)
    }

    private var clampedY: CGFloat {
        min(max(currentY, topY), bottomY)
    }

    var body: some View {
        GeometryReader { geo in
            let width: CGFloat = 16
            let height = bottomY - topY

            ZStack {
                // Main rail
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 3)
                    .frame(width: width, height: height)
                    .position(x: geo.size.width / 2, y: (topY + bottomY) / 2)

                // Top cap
                Circle()
                    .fill(Color(red: 232/255, green: 161/255, blue: 58/255))
                    .frame(width: 24, height: 24)
                    .position(x: geo.size.width / 2, y: topY)

                // Solid segment up to marker
                if clampedY > topY + markerRadius {
                    Rectangle()
                        .fill(railColor)
                        .frame(width: width, height: clampedY - topY - markerRadius)
                        .position(x: geo.size.width / 2,
                                  y: topY + (clampedY - topY - markerRadius) / 2 + markerRadius / 2)
                }

                // Dotted segment below marker
                let start = clampedY + markerRadius + 8
                ForEach(Array(stride(from: start, through: bottomY - 4, by: 16)), id: \.self) { y in
                    Rectangle()
                        .fill(railColor)
                        .frame(width: 8, height: 8)
                        .position(x: geo.size.width / 2, y: y)
                }

                // Marker with sun or moon
                Circle()
                    .stroke(Color.black, lineWidth: 3)
                    .frame(width: markerRadius * 2, height: markerRadius * 2)
                    .position(x: geo.size.width / 2, y: clampedY)
                    .overlay(
                        Group {
                            if isNight {
                                Image(systemName: "moon.fill")
                            } else {
                                Image(systemName: "sun.max.fill")
                            }
                        }
                        .resizable()
                        .scaledToFit()
                        .padding(4)
                        .foregroundColor(railColor)
                    )
            }
        }
    }
}

#Preview {
    SolarRailView(topY: 20, bottomY: 300, currentY: 150, isNight: false, day: Date())
        .frame(width: 100, height: 400)
}
