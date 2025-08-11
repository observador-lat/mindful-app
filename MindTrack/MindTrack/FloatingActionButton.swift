import SwiftUI

struct FloatingActionButton: View {
    @State private var ringScale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                .scaleEffect(ringScale)
            Circle()
                .stroke(Color.blue.opacity(0.2), lineWidth: 4)
                .scaleEffect(ringScale * 1.2)
            Circle()
                .fill(Color.blue)
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                )
        }
        .frame(width: 100, height: 100)
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                ringScale = 1.2
            }
        }
    }
}

#Preview {
    FloatingActionButton()
}
