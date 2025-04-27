//
//  SummaryView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var signUpData: SignUpData
    @State private var isSaving = false
    @State private var signupComplete = false

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
                    SummaryRow(label: "Email", value: signUpData.email)
                    SummaryRow(label: "Gender", value: signUpData.gender)
                    SummaryRow(label: "Age", value: "\(signUpData.age) years")
                    SummaryRow(
                        label: "Height", value: "\(signUpData.height) cm")
                    SummaryRow(
                        label: "Weight", value: "\(signUpData.weight) kg")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    print("User submitted signup!")
                    print("Data: \(signUpData)")
                    // Here you would trigger actual signup process (API call etc.)
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
        isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Here is where you would call your real API
            print("User signed up successfully!")
            print("Email: \(signUpData.email)")
            print("Password: \(signUpData.password)")
            print("Gender: \(signUpData.gender)")
            print("Age: \(signUpData.age)")
            print("Height: \(signUpData.height)")
            print("Weight: \(signUpData.weight)")

            isSaving = false
            signupComplete = true
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
    SummaryView(signUpData: SignUpData())
}
