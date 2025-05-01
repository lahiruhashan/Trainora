//
//  PlannerView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct PlannerView: View {
    // Selected Date
    @State private var selectedDate: Date = Date()

    // Planned workouts mapped by date
    @State private var plannedWorkouts: [String: String] = [:]

    // Workout Picker Sheet
    @State private var isShowingWorkoutPicker = false

    // Example dynamic workout list
    @State private var dailyWorkouts: [Workout] = [
        Workout(
            calories: 120, title: "Upper Body Workout", date: "June 09",
            duration: 25),
        Workout(
            calories: 90, title: "Yoga & Flexibility", date: "June 09",
            duration: 40),
        Workout(
            calories: 150, title: "Cardio Blast", date: "June 09", duration: 30),
    ]

    // Available Workout Options
    private let availableWorkouts = [
        "Cardio Session",
        "Strength Training",
        "Yoga & Flexibility",
        "HIIT Workout",
        "Cycling",
        "Pilates",
        "Rest Day",
    ]

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private var upcomingDates: [Date] {
        var dates: [Date] = []
        let today = Date()
        for i in 0..<30 {
            if let date = Calendar.current.date(
                byAdding: .day, value: i, to: today)
            {
                dates.append(date)
            }
        }
        return dates
    }

    var body: some View {
        NavigationView {
            VStack {
                // Calendar Strip
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(upcomingDates, id: \.self) { date in
                            VStack {
                                Text(shortWeekdayString(from: date))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(dayString(from: date))
                                    .font(.headline)
                                    .fontWeight(
                                        dateFormatter.string(from: date)
                                            == dateFormatter.string(
                                                from: selectedDate)
                                            ? .bold : .regular
                                    )
                                    .foregroundColor(
                                        dateFormatter.string(from: date)
                                            == dateFormatter.string(
                                                from: selectedDate)
                                            ? .white : .primary
                                    )
                                    .frame(width: 40, height: 40)
                                    .background(
                                        dateFormatter.string(from: date)
                                            == dateFormatter.string(
                                                from: selectedDate)
                                            ? Color.blue : Color.clear
                                    )
                                    .clipShape(Circle())
                            }
                            .onTapGesture {
                                selectedDate = date
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(Color.gray.opacity(0.1))

                Divider()

                // Workout Details
                VStack(alignment: .leading, spacing: 20) {
                    Text("Workout Plan for \(formattedDate(selectedDate))")
                        .font(.title3)
                        .fontWeight(.semibold)

                    List {
                        ForEach(
                            Array(dailyWorkouts.enumerated()), id: \.element.id
                        ) { index, workout in
                            WorkoutCardView(
                                calories: workout.calories,
                                title: workout.title,
                                duration: workout.duration
                            )
                            .transition(.move(edge: .trailing))
                            .animation(
                                .easeOut(duration: 0.5).delay(
                                    0.1 * Double(index)), value: dailyWorkouts
                            )
                            .listRowSeparator(.hidden)  // No ugly separator lines
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteWorkout)
                    }.listStyle(PlainListStyle())

                    Spacer()

                    Button(action: {
                        isShowingWorkoutPicker = true
                    }) {
                        Text("Edit Workout")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $isShowingWorkoutPicker) {
                        ExercisePickerView(availableExercises: sampleExercises)
                        { selectedExercise in
                            plannedWorkouts[
                                dateFormatter.string(from: selectedDate)] =
                                selectedExercise.title
                        }
                    }
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Planner")
        }
    }

    // Helper Functions
    private func shortWeekdayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }

    private func dayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    // Swipe to delete function
    private func deleteWorkout(at offsets: IndexSet) {
        dailyWorkouts.remove(atOffsets: offsets)
    }
}

struct Workout: Identifiable, Equatable {
    var id = UUID()
    var calories: Int
    var title: String
    var date: String
    var duration: Int
}

private var sampleExercises: [Exercise] {
    [
    ]
}

#Preview {
    PlannerView()
}
