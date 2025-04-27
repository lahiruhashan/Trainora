//
//  GenderSelectionView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct GenderSelectionView: View {
    @State private var selectedGender: String? = nil
    @Environment(\.dismiss) var dismiss

    @ObservedObject var signUpData: SignUpData
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("Select Your Gender")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            // Gender Options
            VStack(spacing: 15) {
                GenderOptionButton(
                    title: "Male", isSelected: selectedGender == "Male"
                ) {
                    selectedGender = "Male"
                }

                GenderOptionButton(
                    title: "Female", isSelected: selectedGender == "Female"
                ) {
                    selectedGender = "Female"
                }
            }
            .padding(.horizontal)

            Spacer()

            // Continue Button
            Button(action: {
                if let gender = selectedGender {
                    signUpData.gender = gender
                    path.append(3)
                }
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        selectedGender != nil
                            ? Color.blue : Color.gray.opacity(0.5)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(selectedGender == nil)
        }
        .padding()
        .navigationTitle("Gender")
        .navigationBarBackButtonHidden(false)
    }
}

struct GenderOptionButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

#Preview {
    GenderSelectionView(
        signUpData: SignUpData(),  // Dummy model instance
        path: .constant(NavigationPath())  // Dummy binding
    )
}
