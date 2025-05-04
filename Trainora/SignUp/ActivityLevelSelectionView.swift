//
//  ActivityLevelSelectionView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/1/25.
//

import SwiftUI

struct ActivityLevelSelectionView: View {
    @ObservedObject var signUpData: SignUpData
    var onContinue: () -> Void

    @State private var selectedLevel: String? = nil

    let levels = ["Beginner", "Intermediate", "Advanced"]

    var body: some View {
        VStack(spacing: 30) {
            Text("Select Your Activity Level")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            VStack(spacing: 15) {
                ForEach(levels, id: \.self) { level in
                    Button(action: {
                        selectedLevel = level
                    }) {
                        HStack {
                            Text(level)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: selectedLevel == level ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(selectedLevel == level ? .blue : .gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                if let level = selectedLevel {
                    signUpData.activityLevel = level
                    onContinue()
                }
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedLevel != nil ? Color.blue : Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(selectedLevel == nil)
        }
        .padding()
    }
}


#Preview {
    ActivityLevelSelectionView(signUpData: SignUpData(), onContinue: {}  )
}
