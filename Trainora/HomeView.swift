//
//  HomeView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userSession: UserSession
    var onProfileTapped: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    AppTitleView()

                    Spacer()

                    Button(action: {
                        onProfileTapped()
                    }) {
                        Image(
                            uiImage: ImageStorage.loadImage(
                                named: userSession.currentUser?.profileImageName
                                    ?? ""
                            )
                        )
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Greeting
                        Text(greetingMessage())
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)

                        NavigationLink(destination: PlannerView()) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Your Workout Planner")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)

                                        Text("Today Plan")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)

                                        if viewModel.plannedWorkoutCount > 0 {
                                            Text(
                                                "\(viewModel.plannedWorkoutCount) Workouts Planned"
                                            )
                                            .font(.caption)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(
                                                Color.green.opacity(0.2)
                                            )
                                            .foregroundColor(.green)
                                            .cornerRadius(6)
                                        } else {
                                            Text("No Workouts Planned")
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(
                                                    Color.red.opacity(0.2)
                                                )
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
                            .shadow(
                                color: Color.black.opacity(0.1),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                        }

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
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(
                            color: Color.black.opacity(0.1),
                            radius: 8,
                            x: 0,
                            y: 4
                        )

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
                                        RoundedRectangle(cornerRadius: 5)
                                    )

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
        let baseGreeting: String

        switch hour {
        case 0..<12: baseGreeting = "Good Morning"
        case 12..<17: baseGreeting = "Good Afternoon"
        case 17..<24: baseGreeting = "Good Evening"
        default: baseGreeting = "Welcome Back"
        }

        return "\(baseGreeting), \(appState.loggedInUserName)!"
    }
}

#Preview {
    //   HomeView()
}
