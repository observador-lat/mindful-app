//
//  ContentView.swift
//  MindTrack
//
//  Created by Jorge Carrasco on 9/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .border(Color.black)
                .accessibilityLabel("Globe icon")
                .accessibilityHint("Represents the world.")
            Button(action: {}) {
                Text("Start")
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .border(Color.black)
            .accessibilityLabel("Start button")
            .accessibilityHint("Begins tracking.")
            Text("Hello, world!")
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
