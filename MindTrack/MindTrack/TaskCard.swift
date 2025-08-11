//
//  TaskCard.swift
//  MindTrack
//
//  Created by OpenAI on 2024-05-15.
//
import SwiftUI

enum TaskCategory {
    case calm
    case focus
    case growth
    case calmDimmed

    var color: Color {
        switch self {
        case .calm:
            return Color(red: 206/255, green: 234/255, blue: 221/255)
        case .focus:
            return Color(red: 232/255, green: 161/255, blue: 58/255)
        case .growth:
            return Color(red: 98/255, green: 178/255, blue: 115/255)
        case .calmDimmed:
            return Color(.sRGB, red: 206/255, green: 234/255, blue: 221/255, opacity: 0.85)
        }
    }
}

struct TaskCard: View {
    let title: String
    let timeRange: String
    let icon: String
    let category: TaskCategory
    var focusMode: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(category.color)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.black, lineWidth: 4)
                )

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 26, weight: .bold))
                        .lineLimit(1)
                    Text(timeRange)
                        .font(.system(size: 17))
                        .foregroundColor(.black.opacity(0.75))
                    if focusMode {
                        Text("FOCUS MODE")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(
                                Color(red: 232/255, green: 161/255, blue: 58/255)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(12)
                    }
                }
                .padding(.leading, 18)
                Spacer()
                Circle()
                    .fill(Color.white.opacity(0.55))
                    .frame(width: 56, height: 56)
                    .overlay(
                        Circle().stroke(Color.black, lineWidth: 2)
                    )
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 22))
                    )
                    .padding(.trailing, 18)
            }
            .padding(.vertical, 18)
        }
    }
}

#Preview {
    TaskCard(title: "Morning Run", timeRange: "6:00 AM - 7:00 AM", icon: "figure.run", category: .growth, focusMode: true)
}
