import Foundation
import WeatherKit
import CoreLocation

struct SunTimesManager {
    private let service = WeatherService.shared
    private let calendar = Calendar.current
    
    func sunset(for day: Date, location: CLLocation) async -> Date {
        do {
            let daily = try await service.weather(for: location, including: .daily)
            if let sunset = daily.forecast.first?.sun.sunset {
                return sunset
            }
        } catch {
            // Fallback handled below
        }
        return calendar.date(bySettingHour: 18, minute: 0, second: 0, of: day) ?? day
    }
    
    func isNight(at date: Date = Date(), location: CLLocation) async -> Bool {
        let sunsetTime = await sunset(for: date, location: location)
        return date >= sunsetTime
    }
}
