//
//  SignUpCompleteView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignUpCompleteView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 30) {
            Text("🎉")
                .font(.system(size: 80))

            Text("Account Created!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Welcome to Trainora!")
                .font(.title2)
                .foregroundColor(.gray)

            Spacer()

            Button(action: {
                print("Go to Home Screen or Dashboard!")
                appState.isSignedIn = true
            }) {
                Text("Get Started")
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
    SignUpCompleteView()
}
