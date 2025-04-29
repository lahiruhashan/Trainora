//
//  HomeView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // App Title on the left
                    AppTitleView()

                    Spacer()

                    // Profile Picture on the right
                    Button(action: {
                        print("Profile tapped!")  // Future navigation to profile
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .shadow(radius: 2)
                            )
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Greeting
                        Text(greetingMessage())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)

                        // Workout of the Day Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Workout of the Day")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    Text(viewModel.workoutOfTheDay)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)

                                    Text("Category: Strength")  // Static for now, dynamic later
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.2))
                                        .foregroundColor(.blue)
                                        .cornerRadius(6)
                                }

                                Spacer()

                                // Icon
                                Image(systemName: "flame.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.8),
                                    Color.blue.opacity(0.2),
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                        .cornerRadius(15)
                        .shadow(
                            color: Color.black.opacity(0.1), radius: 8, x: 0,
                            y: 4)
                        
                        NavigationLink(destination: PlannerView()) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Your Workout Planner")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)

                                        Text("Plan and Edit Workouts")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)

                                        // 🔥 Dynamic Badge
                                        if viewModel.plannedWorkoutCount > 0 {
                                            Text("\(viewModel.plannedWorkoutCount) Workouts Planned")
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.green.opacity(0.2))
                                                .foregroundColor(.green)
                                                .cornerRadius(6)
                                        } else {
                                            Text("No Workouts Planned")
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.red.opacity(0.2))
                                                .foregroundColor(.red)
                                                .cornerRadius(6)
                                        }
                                    }

                                    Spacer()

                                    Image(systemName: "calendar.badge.clock")
                                        .font(.largeTitle)
                                        .foregroundColor(.purple)
                                }
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.8),
                                        Color.purple.opacity(0.2),
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        }


                        // Motivational Quote
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Motivational Quote")
                                .font(.headline)
                            Text("“\(viewModel.motivationalQuote)”")
                                .italic()
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(10)
                        }

                        // Progress Summary with Progress Bar
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Progress Summary")
                                .font(.headline)

                            VStack(alignment: .leading, spacing: 8) {
                                // Progress Bar
                                ProgressView(value: viewModel.progressValue)
                                    .progressViewStyle(
                                        LinearProgressViewStyle(tint: .green)
                                    )
                                    .frame(height: 10)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 5))

                                // Progress Text
                                Text(viewModel.progressText)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                        }

                        Spacer()
                    }
                    .padding()
                }
            }

        }
    }

    // Dynamic Greeting based on time of day
    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12: return "Good Morning!"
        case 12..<17: return "Good Afternoon!"
        case 17..<22: return "Good Evening!"
        default: return "Welcome Back!"
        }
    }
}

#Preview {
    HomeView()
}
