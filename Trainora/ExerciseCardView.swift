//
//  ExerciseCardView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct ExerciseCardView: View {
    let exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                Image(systemName: "figure.walk") // Customize icons later
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(exercise.calories) Kcal")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(exercise.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("\(exercise.duration) mins")
                    .font(.caption)
                    .foregroundColor(.blue)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)
    }
}

struct Exercise: Identifiable, Equatable {
    var id = UUID()
    var calories: Int
    var title: String
    var duration: Int
}


#Preview {
    ExerciseCardView(
        exercise: Exercise(calories: 120, title: "Upper Body", duration: 25)
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}
