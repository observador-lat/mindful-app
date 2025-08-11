import SwiftUI

struct ContentView: View {
    @State private var currentY: CGFloat = 0
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 4, height: 300)
                    .overlay(alignment: .top) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                            .offset(y: currentY)
                            .animation(.linear(duration: 0.5), value: currentY)
                    }
            }
            FloatingActionButton()
                .padding()
        }
        .onAppear {
            currentY = computeCurrentY()
        }
        .onReceive(timer) { _ in
            currentY = computeCurrentY()
        }
    }

    private func computeCurrentY() -> CGFloat {
        let minute = Calendar.current.component(.minute, from: Date())
        return CGFloat(minute) * 4
    }
}

#Preview {
    ContentView()
}
