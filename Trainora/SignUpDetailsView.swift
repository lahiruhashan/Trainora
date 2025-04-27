//
//  SignUpDetailsView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignUpDetailsView: View {
    @State private var weight = ""
    @State private var height = ""
    @State private var age = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            AppTitleView()
            Text("Tell us more")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            TextField("Weight (kg)", text: $weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)

            TextField("Height (cm)", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)

            TextField("Age", text: $age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            Button(action: {
                print("Save data and complete sign up")
                dismiss() // After completion, go back or move to home
            }) {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                print("Skipped extra details")
                dismiss() // Skip and go back or move to home
            }) {
                Text("Skip for Now")
                    .foregroundColor(.gray)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding()
    }
}


#Preview {
    SignUpDetailsView()
}
