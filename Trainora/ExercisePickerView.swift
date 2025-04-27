//
//  WorkoutPickerView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct WorkoutPickerView: View {
    let availableWorkouts: [String]
    var onWorkoutSelected: (String) -> Void

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List(availableWorkouts, id: \.self) { workout in
                Button(action: {
                    onWorkoutSelected(workout)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(workout)
                        .padding()
                }
            }
            .navigationTitle("Select Workout")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    WorkoutPickerView(availableWorkouts: ["Cardio", "Yoga"]) { _ in }
}
