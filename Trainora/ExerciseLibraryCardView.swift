//
//  ExerciseLibraryCardView.swift
//  Trainora
//
//  Created by user266021 on 5/1/25.
//


import SwiftUIstruct ExerciseLibraryCardView: View {    let exercise: Exercise    let onFavoriteTapped: () -> Void    var body: some View {        HStack(alignment: .top, spacing: 12) {            Image(exercise.imageName)                .resizable()                .scaledToFill()                .frame(width: 60, height: 60)                .clipShape(RoundedRectangle(cornerRadius: 12))            VStack(alignment: .leading, spacing: 6) {                HStack {                    Text(exercise.title)                        .font(.headline)                    Spacer()                    Button(action: onFavoriteTapped) {                        Image(systemName: exercise.isFavorite ? "heart.fill" : "heart")                            .foregroundColor(.red)                    }                }                Text(exercise.description)                    .font(.subheadline)                    .lineLimit(2)                    .foregroundColor(.secondary)                Text("🔥 \(exercise.calories) kcal • ⏱ \(exercise.duration) min • 🏋️‍♂️ \(exercise.reps) reps")                    .font(.footnote)                    .foregroundColor(.secondary)            }        }        .padding(.vertical, 8)    }}