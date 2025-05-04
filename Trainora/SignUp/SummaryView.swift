//
//  SummaryView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI
import CoreData

struct SummaryView: View {
    @ObservedObject var signUpData: SignUpData
    @State private var isSaving = false
    @State private var signupComplete = false
    var onFinish: () -> Void
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 30) {
            if isSaving {
                ProgressView("Creating your account...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .font(.title2)
                    .padding()
            } else {
                Text("Review Your Information")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                VStack(spacing: 20) {
                    SummaryRow(label: "First Name", value: signUpData.firstName)
                    SummaryRow(label: "Last Name", value: signUpData.lastName)
                    SummaryRow(label: "Email", value: signUpData.email)
                    SummaryRow(label: "Gender", value: signUpData.gender)
                    SummaryRow(label: "Age", value: "\(signUpData.age) years")
                    SummaryRow(
                        label: "Height", value: "\(signUpData.height) cm")
                    SummaryRow(
                        label: "Weight", value: "\(signUpData.weight) kg")
                    SummaryRow(label: "Activity Level", value: signUpData.activityLevel)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    print("User submitted signup!")
                    print("Data: \(signUpData)")
                    onFinish()
                    saveUserData()
                }) {
                    Text("Finish and Create Account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .navigationTitle("Summary")
        .navigationBarBackButtonHidden(false)
        .fullScreenCover(isPresented: $signupComplete) {
            SignUpCompleteView()
        }
    }

    func saveUserData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let user = UserProfileEntity(context: viewContext)
            user.email = signUpData.email
            user.password = signUpData.password
            user.gender = signUpData.gender
            user.age = Int16(signUpData.age)
            user.height = Double(signUpData.height)
            user.weight = Double(signUpData.weight)
            user.firstName = signUpData.firstName
            user.lastName = signUpData.lastName
            user.experience = signUpData.activityLevel

            do {
                try viewContext.save()
                print("User saved to Core Data")

                isSaving = false
                signupComplete = true
                
                appState.loggedInUserName = signUpData.firstName
            } catch {
                print("Failed to save user: \(error.localizedDescription)")
                isSaving = false
            }
        }
    }
}

struct SummaryRow: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()

            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    SummaryView(signUpData: SignUpData(), onFinish: {})
}
