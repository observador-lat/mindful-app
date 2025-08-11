import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var isNight = false
    private let sunManager = SunTimesManager()
    private let location = CLLocation(latitude: 0, longitude: 0)
    
    var body: some View {
        SolarRailView(isNight: isNight)
            .task {
                isNight = await sunManager.isNight(at: Date(), location: location)
            }
            .padding()
    }
}

#Preview {
    ContentView()
}
