//
//  AgeSelectionView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct AgeSelectionView: View {
    @State private var selectedAge: Int = 28
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var signUpData: SignUpData
//    @Binding var path: NavigationPath
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("How Old Are You?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            // Subtitle (optional text)
            Text("We use your age to personalize your fitness journey.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Spacer()

            // Selected Age Number
            Text("\(selectedAge)")
                .font(.system(size: 60, weight: .bold))
                .padding(.bottom, 10)

            // Horizontal Picker
            Picker(selection: $selectedAge, label: Text("")) {
                ForEach(13...100, id: \.self) { age in
                    Text("\(age)").tag(age)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            .clipped()

            Spacer()

            // Continue Button
            Button(action: {
                print("Selected Age: \(selectedAge)")
                signUpData.age = selectedAge
                onContinue()
//                path.append(SignUpStep.height)
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
        }
        .padding()
        .navigationTitle("Age")
        .navigationBarBackButtonHidden(false) // Show Back Button
    }
}


#Preview {
    AgeSelectionView(
        signUpData: SignUpData(), onContinue: {}  // Dummy model instance
//        path: .constant(NavigationPath())  // Dummy binding
    )
}
