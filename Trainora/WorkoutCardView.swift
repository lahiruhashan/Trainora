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
    let date: String
    let duration: Int

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Left Icon
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                Image(systemName: "figure.walk") // Change icon if needed
                    .foregroundColor(.white)
                    .font(.title3)
            }

            VStack(alignment: .leading, spacing: 4) {
                // Top Calories
                Text("\(calories) Kcal")
                    .font(.caption)
                    .foregroundColor(.gray)

                // Workout Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                // Date
                Text(date)
                    .font(.caption)
                    .foregroundColor(.blue)
            }

            Spacer()

            // Duration
            VStack(alignment: .trailing, spacing: 4) {
                Text("Duration")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("\(duration) Mins")
                    .font(.subheadline)
                    .foregroundColor(.blue)
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
        date: "June 09",
        duration: 25
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}
