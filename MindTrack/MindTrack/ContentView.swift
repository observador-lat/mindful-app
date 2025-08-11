import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let start: Date
    let end: Date
}

struct ContentView: View {
    private let tasks: [Task]

    @State private var topY: CGFloat?
    @State private var bottomY: CGFloat?
    @State private var currentY: CGFloat = 0

    init() {
        let calendar = Calendar.current
        let today = Date()
        tasks = [
            Task(title: "Breakfast", start: calendar.date(bySettingHour: 8, minute: 0, second: 0, of: today)!, end: calendar.date(bySettingHour: 9, minute: 0, second: 0, of: today)! ),
            Task(title: "Work", start: calendar.date(bySettingHour: 9, minute: 30, second: 0, of: today)!, end: calendar.date(bySettingHour: 12, minute: 0, second: 0, of: today)! ),
            Task(title: "Lunch", start: calendar.date(bySettingHour: 13, minute: 0, second: 0, of: today)!, end: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: today)! ),
            Task(title: "Study", start: calendar.date(bySettingHour: 15, minute: 0, second: 0, of: today)!, end: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: today)! ),
        ]
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
                    TaskCard(task: task)
                        .modifier(AnchorModifier(index: index, total: tasks.count))
                }
            }
            .padding()
        }
        .coordinateSpace(name: "scrollArea")
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onPreferenceChange(TopYPreference.self) { anchor in
                        if let anchor = anchor {
                            topY = proxy[anchor, in: .named("scrollArea")].minY
                            updateCurrentY()
                        }
                    }
                    .onPreferenceChange(BottomYPreference.self) { anchor in
                        if let anchor = anchor {
                            bottomY = proxy[anchor, in: .named("scrollArea")].maxY
                            updateCurrentY()
                        }
                    }
                    .overlay(
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 2)
                            .position(x: proxy.size.width / 2, y: currentY)
                    )
            }
        )
    }

    private var firstTask: Task { tasks.first! }
    private var lastTask: Task { tasks.last! }

    private func updateCurrentY() {
        guard let topY = topY, let bottomY = bottomY else { return }
        let startHour = hourValue(of: firstTask.start)
        let endHour = hourValue(of: lastTask.end)
        let currentHour = hourValue(of: Date())
        let progress = (currentHour - startHour) / (endHour - startHour)
        currentY = topY + (bottomY - topY) * CGFloat(progress)
    }

    private func hourValue(of date: Date) -> Double {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = Double(comps.hour ?? 0)
        let minute = Double(comps.minute ?? 0) / 60.0
        return hour + minute
    }
}

struct TaskCard: View {
    let task: Task

    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title).font(.headline)
            Text("\(format(task.start)) - \(format(task.end))")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
        )
    }

    private func format(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct AnchorModifier: ViewModifier {
    let index: Int
    let total: Int

    func body(content: Content) -> some View {
        if index == 0 {
            content.anchorPreference(key: TopYPreference.self, value: .bounds) { $0 }
        } else if index == total - 1 {
            content.anchorPreference(key: BottomYPreference.self, value: .bounds) { $0 }
        } else {
            content
        }
    }
}

#Preview {
    ContentView()
}
