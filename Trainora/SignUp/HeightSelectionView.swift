//
//  HeightSelectionView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct HeightSelectionView: View {
    @ObservedObject var signUpData: SignUpData
    @State private var selectedHeight: Int = 170
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("What's Your Height?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            Spacer()

            // Selected Height Display
            Text("\(selectedHeight) cm")
                .font(.system(size: 60, weight: .bold))
                .padding(.bottom, 10)

            // Wheel Picker
            Picker(selection: $selectedHeight, label: Text("")) {
                ForEach(100...250, id: \.self) { height in
                    Text("\(height)").tag(height)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            .clipped()

            Spacer()

            Button(action: {
                signUpData.height = Double(selectedHeight)
                onContinue()
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
    }
}


#Preview {
    HeightSelectionView(
        signUpData: SignUpData(), onContinue: {}
    )
}
