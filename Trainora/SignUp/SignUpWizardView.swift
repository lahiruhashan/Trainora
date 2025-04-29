//
//  SignUpWizardView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignUpWizardView: View {
    @StateObject private var signUpData = SignUpData()
    @EnvironmentObject var appState: AppState
    @State private var currentStep: SignUpStep = .email

    var body: some View {
        VStack {
            switch currentStep {
            case .email:
                SignUpView(signUpData: signUpData) {
                    currentStep = .gender
                }
            case .gender:
                GenderSelectionView(signUpData: signUpData) {
                    currentStep = .age
                }
            case .age:
                AgeSelectionView(signUpData: signUpData) {
                    currentStep = .height
                }
            case .height:
                HeightSelectionView(signUpData: signUpData) {
                    currentStep = .weight
                }
            case .weight:
                WeightSelectionView(signUpData: signUpData) {
                    currentStep = .summary
                }
            case .summary:
                SummaryView(signUpData: signUpData) {
                    appState.isSignedIn = true
                }

            }
        }
        .animation(.easeInOut, value: currentStep)
        .transition(.slide)
    }
}

#Preview {
    SignUpWizardView()
}
