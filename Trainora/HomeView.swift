//
//  HomeView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import SwiftUI

struct HomeView: View {
    // Temporary dummy data
    let motivationalQuote = "Push yourself because no one else is going to do it for you."
    let workoutOfTheDay = "Full Body Workout - 30 Minutes"
    let progressSummary = "Completed 3/5 workouts this week."

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Greeting
                    Text(greetingMessage())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)

                    // Workout of the Day
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Workout of the Day")
                            .font(.headline)
                        Text(workoutOfTheDay)
                            .font(.body)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }

                    // Motivational Quote
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Motivational Quote")
                            .font(.headline)
                        Text("“\(motivationalQuote)”")
                            .italic()
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                    }

                    // Progress Summary
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Progress Summary")
                            .font(.headline)
                        Text(progressSummary)
                            .font(.body)
                            .padding()
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Trainora")
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
