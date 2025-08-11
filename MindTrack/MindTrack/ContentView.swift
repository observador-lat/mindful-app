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
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }

            Text("Siguiente Tarea en 10 h")
                .font(.headline)
                .padding(.top, 20)

            Button(action: {
                // Acción para añadir tarea
            }) {
                HStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 22, height: 22)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        )

                    Text("AÑADIR TAREA")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "E8674D").opacity(0.9))
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.black, lineWidth: 2)
                )
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
