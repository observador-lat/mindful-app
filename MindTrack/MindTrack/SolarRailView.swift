import SwiftUI

/// A vertical rail showing progress with a solid body and dotted remainder.
struct SolarRailView: View {
    /// The y-position where the rail begins beneath the top cap.
    var topY: CGFloat
    /// The y-position where the rail ends above the bottom bar.
    var bottomY: CGFloat
    /// The current marker position along the rail.
    var currentY: CGFloat
    /// Radius of the marker that indicates the current position.
    var markerRadius: CGFloat

    var body: some View {
        Canvas { context, size in
            // Rail rectangle spanning from topY to bottomY
            let railWidth: CGFloat = 10
            let railRect = CGRect(
                x: (size.width - railWidth) / 2,
                y: topY,
                width: railWidth,
                height: bottomY - topY
            )

            // Draw rail outline with black border width 3
            let railPath = Path(roundedRect: railRect, cornerRadius: railWidth / 2)
            context.stroke(railPath, with: .color(.black), lineWidth: 3)

            // Solid body from just below the cap down to currentY - markerRadius
            let solidEndY = max(topY, currentY - markerRadius)
            if solidEndY > topY {
                let solidRect = CGRect(
                    x: railRect.minX,
                    y: topY,
                    width: railWidth,
                    height: solidEndY - topY
                )
                let solidPath = Path(roundedRect: solidRect, cornerRadius: railWidth / 2)
                context.fill(solidPath, with: .color(.orange))
            }

            // Dotted line from currentY + markerRadius down to bottomY (without touching)
            let dottedStart = currentY + markerRadius
            let dottedEnd = bottomY - 1 // leave a small gap above bottom bar
            if dottedEnd > dottedStart {
                var dottedPath = Path()
                dottedPath.move(to: CGPoint(x: railRect.midX, y: dottedStart))
                dottedPath.addLine(to: CGPoint(x: railRect.midX, y: dottedEnd))
                let style = StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2, 2])
                context.stroke(dottedPath, with: .color(.black), style: style)
            }
        }
    }
}

#Preview {
    SolarRailView(topY: 10, bottomY: 200, currentY: 80, markerRadius: 6)
        .frame(width: 40, height: 220)
        .padding()
}
