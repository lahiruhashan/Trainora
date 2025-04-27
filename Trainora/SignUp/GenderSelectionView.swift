//
//  GenderSelectionView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct GenderSelectionView: View {
    @State private var selectedGender: String? = nil
    @State private var navigateToAge = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("Select Your Gender")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            // Gender Options
            VStack(spacing: 15) {
                GenderOptionButton(title: "Male", isSelected: selectedGender == "Male") {
                    selectedGender = "Male"
                }

                GenderOptionButton(title: "Female", isSelected: selectedGender == "Female") {
                    selectedGender = "Female"
                }
            }
            .padding(.horizontal)

            Spacer()

            // Continue Button
            Button(action: {
                print("Selected Gender: \(selectedGender ?? "None")")
                navigateToAge = true
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedGender != nil ? Color.blue : Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(selectedGender == nil)
        }
        .padding()
        .navigationTitle("Gender")
        .navigationBarBackButtonHidden(false)
        .navigationDestination(isPresented: $navigateToAge) {
            AgeSelectionView()
        }
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
    GenderSelectionView()
}
