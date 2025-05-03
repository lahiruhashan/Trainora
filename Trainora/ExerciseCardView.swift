//
//  ExerciseCardView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct ExerciseCardView: View {
    let exercise: Exercise
    @State private var isDone: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                Image(systemName: "figure.walk")  // Customize icons later
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
