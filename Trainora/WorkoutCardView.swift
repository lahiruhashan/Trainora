//
//  WorkoutCardView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct WorkoutCardView: View {
    let calories: Int
    let title: String
    let duration: Int

    @State private var isDone: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Left Icon
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                Image(systemName: "figure.walk")
                    .foregroundColor(.white)
                    .font(.title3)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(calories) Kcal")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("\(duration) Mins")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }

            Spacer()

            // Duration
            VStack(alignment: .trailing, spacing: 4) {
                
                Button(action: {
                    isDone.toggle()
                }) {
                    Image(
                        systemName: isDone ? "checkmark.circle.fill" : "circle"
                    )
                    .foregroundColor(isDone ? .green : .gray)
                    .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)
        .frame(height: 80)
    }
}

#Preview {
    WorkoutCardView(
        calories: 120,
        title: "Upper Body Workout",
        duration: 25
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}
