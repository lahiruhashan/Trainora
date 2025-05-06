//
//  PlannerView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import CoreData
import SwiftUI

struct PlannerView: View {
    // Selected Date (only date part, no time)
    @State private var selectedDate: Date = Calendar.current.startOfDay(
        for: Date())

    // Planned workouts mapped by date
    @State private var plannedWorkouts: [String: String] = [:]

    // Workout Picker Sheet
    @State private var isShowingWorkoutPicker = false

    @Environment(\.managedObjectContext) private var viewContext

    @State private var sampleExercises: [ExerciseEntity] = []

    @State private var dailyWorkouts: [ExerciseEntity] = []

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

    private var indexedExercises: [(Int, ExerciseEntity)] {
        Array(dailyWorkouts.enumerated())
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
                                selectedDate = Calendar.current.startOfDay(
                                    for: date)
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
                        ForEach(indexedExercises, id: \.1.id) {
                            index, workout in
                            WorkoutListItem(workout: workout, index: index)
                        }
                        .onDelete(perform: deleteWorkout)
                    }

                    Spacer()

                    Button(action: {
                        loadExercises()
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
                        ExercisePickerView(
                            availableExercises: $sampleExercises,
                            isPresented: $isShowingWorkoutPicker
                        ) { selectedExercise in
                            addExerciseToWorkout(selectedExercise, for: selectedDate)
                        }
                    }

                }
                .padding()

                Spacer()
            }
            .navigationTitle("Planner")
            .onAppear {
                loadWorkouts(for: selectedDate)
            }
            .onChange(of: selectedDate) { _, newDate in
                loadWorkouts(for: selectedDate)
            }
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
        for index in offsets {
            let exerciseToDelete = indexedExercises[index].1

            // Get the workout associated with this date
            guard
                let workout = exerciseToDelete.workout?.allObjects
                    .compactMap({ $0 as? WorkoutEntity })
                    .first(where: { $0.date == selectedDate.startOfDay })
            else {
                print("⚠️ No matching workout found for selected date.")
                return
            }

            // 🔍 Debug Print: Workout details
            print("📆 Workout to update/remove exercise from:")
            print("- ID: \(workout.id?.uuidString ?? "nil")")
            print("- Date: \(workout.date?.description ?? "nil")")
            print(
                "- Exercise count before removal: \(workout.exercises?.count ?? 0)"
            )
            if let exercises = workout.exercises as? Set<ExerciseEntity> {
                for ex in exercises {
                    print("   - \(ex.title ?? "Unnamed")")
                }
            }

            // Remove the specific exercise from this workout
            workout.removeFromExercises(exerciseToDelete)

            // If no workouts remain, remove the exercise entirely
            let remainingWorkouts = exerciseToDelete.workout?.count ?? 0
            if remainingWorkouts == 1 {
                viewContext.delete(exerciseToDelete)
                print("🗑️ Exercise deleted from Core Data.")
            } else {
                print(
                    "🔗 Exercise still belongs to other workouts. Not deleted.")
            }

            // Save and refresh
            do {
                try viewContext.save()
                print("✅ Workout updated.")
                loadWorkouts(for: selectedDate)
            } catch {
                print("❌ Failed to update workout: \(error)")
            }
        }
    }

    private func loadExercises() {
        let request: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
        do {
            sampleExercises = try viewContext.fetch(request)
            print("✅ Loaded \(sampleExercises.count) exercises from Core Data")
            for e in sampleExercises {
                print("• \(e.title ?? "Unnamed")")
            }
        } catch {
            print("❌ Failed to fetch exercises: \(error)")
            sampleExercises = []
        }
    }

    private func loadWorkouts(for date: Date) {
        dailyWorkouts = []
        let today = selectedDate.startOfDay
        let request: NSFetchRequest<WorkoutEntity> =
            WorkoutEntity.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", date as NSDate)

        do {
            if let workout = try viewContext.fetch(request).first {
                print("✅ Fetched workout for date: \(today)")
                print("Workout ID: \(workout.id?.uuidString ?? "nil")")
                print("Exercise count: \(workout.exercises?.count ?? 0)")

                if let exercises = workout.exercises as? Set<ExerciseEntity> {
                    let sortedExercises = Array(exercises).sorted {
                        $0.title ?? "" < $1.title ?? ""
                    }
                    dailyWorkouts = sortedExercises

                    print("✅ Loaded \(sortedExercises.count) exercises:")
                    for exercise in sortedExercises {
                        print(
                            "• \(exercise.title ?? "Unnamed") | \(exercise.calories) kcal | \(exercise.duration) mins"
                        )
                    }
                } else {
                    print("⚠️ Could not cast exercises to Set<ExerciseEntity>")
                    dailyWorkouts = []
                }
            }

        } catch {
            print("❌ Failed to fetch workout: \(error)")
            dailyWorkouts = []
        }
    }

    private func addExerciseToWorkout(
        _ exercise: ExerciseEntity, for date: Date
    ) {
        let dateKey = Calendar.current.startOfDay(for: date)

        let request: NSFetchRequest<WorkoutEntity> =
            WorkoutEntity.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", dateKey as NSDate)

        do {
            let results = try viewContext.fetch(request)
            let workout: WorkoutEntity

            if let existing = results.first {
                workout = existing
            } else {
                workout = WorkoutEntity(context: viewContext)
                workout.id = UUID()
                workout.date = dateKey
            }

            // Check if the exercise already exists in the workout's exercises set
            if let existingExerciseSet = workout.exercises {
                let exerciseArray =
                    existingExerciseSet.allObjects as! [ExerciseEntity]
                if !exerciseArray.contains(exercise) {
                    // If the exercise isn't already associated with this workout, add it
                    workout.addToExercises(exercise)
                }
            } else {
                // If no exercises are yet associated with the workout, add the exercise
                workout.addToExercises(exercise)
            }

            try viewContext.save()
            print("✅ Exercise added to workout for date \(dateKey)")
            loadWorkouts(for: dateKey)  // Refresh list

        } catch {
            print("❌ Error adding exercise: \(error)")
        }
    }

}

struct Workout: Identifiable, Equatable {
    var id = UUID()
    var calories: Int
    var title: String
    var date: String
    var duration: Int
}

struct WorkoutListItem: View {
    let workout: ExerciseEntity
    let index: Int

    var body: some View {
        WorkoutCardView(
            calories: Int(workout.calories),
            title: workout.title ?? "Unnamed",
            duration: Int(workout.duration)
        )
        .transition(.move(edge: .trailing))
        .animation(
            .easeOut(duration: 0.5).delay(0.1 * Double(index)),
            value: workout
        )
        .listRowSeparator(.hidden)
        .padding(.vertical, 4)
    }
}

#Preview {
    PlannerView()
}
