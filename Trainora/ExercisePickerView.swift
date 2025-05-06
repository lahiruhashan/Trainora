//
//  WorkoutPickerView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct ExercisePickerView: View {
    @Binding var availableExercises: [ExerciseEntity]
    @Binding var isPresented: Bool
    var onExerciseSelected: (ExerciseEntity) -> Void

    var body: some View {
        List(availableExercises, id: \.id) { exercise in
            Button(action: {
                onExerciseSelected(exercise)
                isPresented = false // dismiss the sheet
            }) {
                Text(exercise.title ?? "Unnamed")
            }
        }
    }
}



#Preview {
    
}
