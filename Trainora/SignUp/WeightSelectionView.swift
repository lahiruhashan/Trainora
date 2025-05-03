//
//  WeightSelectionView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct WeightSelectionView: View {
    @ObservedObject var signUpData: SignUpData
    @State private var selectedWeight: Double = 65
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("What's Your Weight?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            Spacer()

            // Selected Weight Display
            Text("\(Double(selectedWeight).roundedToTwoDecimals) kg")
                .font(.system(size: 60, weight: .bold))
                .padding(.bottom, 10)

            // Wheel Picker
            Picker(selection: $selectedWeight, label: Text("")) {
                ForEach(30...200, id: \.self) { weight in
                    Text("\(weight)").tag(weight)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            .clipped()

            Spacer()

            Button(action: {
                signUpData.weight = selectedWeight
                onContinue()
            }) {
                Text("Finish Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}


#Preview {
    WeightSelectionView(
        signUpData: SignUpData(), onContinue: {}
    )
}
