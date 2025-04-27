//
//  WorkoutPickerView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct ExercisePickerView: View {
    let availableExercises: [Exercise]
    var onExerciseSelected: (Exercise) -> Void

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(availableExercises) { exercise in
                        ExerciseCardView(exercise: exercise)
                            .onTapGesture {
                                onExerciseSelected(exercise)
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Select Exercise")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


#Preview {
    
}
