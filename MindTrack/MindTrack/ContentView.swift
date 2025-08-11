//
//  ContentView.swift
//  MindTrack
//
//  Created by Jorge Carrasco on 9/08/25.
//

import SwiftUI

struct ContentView: View {
    private var fechaFormateada: String {
        DateFormatter.esES.string(from: Date())
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Hoy")
                    .font(.system(size: 58, weight: .heavy))
                Text(fechaFormateada)
                    .font(.system(size: 22, weight: .regular))
                    .opacity(0.85)
                Spacer()
            }
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(Color(hex: "F5ECE9"))
        .ignoresSafeArea()
    }
}

private extension DateFormatter {
    static let esES: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es-ES")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            r = (int >> 16) & 0xFF
            g = (int >> 8) & 0xFF
            b = int & 0xFF
        default:
            r = 0
            g = 0
            b = 0
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: 1)
    }
}

#Preview {
    ContentView()
}
