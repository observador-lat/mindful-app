//
//  ContentView.swift
//  MindTrack
//
//  Created by Jorge Carrasco on 9/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    private let localeES = Locale(identifier: "es_ES")
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = localeES
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }

    var body: some View {
        VStack {
            headerView
            
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)

            List(sampleTimes, id: \.self) { date in
                Text(timeFormatter.string(from: date))
            }
        }
        .padding()
    }

    private var headerView: some View {
        if Calendar.current.isDateInToday(selectedDate) {
            Text("Hoy")
        } else {
            Text(selectedDate.formatted(.dateTime.weekday(.wide).locale(localeES)))
        }
    }

    private var sampleTimes: [Date] {
        [
            Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: selectedDate)!,
            Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: selectedDate)!,
            Calendar.current.date(bySettingHour: 18, minute: 15, second: 0, of: selectedDate)!,
        ]
    }
}

#Preview {
    ContentView()
}
