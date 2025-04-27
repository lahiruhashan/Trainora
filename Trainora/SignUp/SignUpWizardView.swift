//
//  SignUpWizardView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignUpWizardView: View {
    @StateObject private var signUpData = SignUpData()
    @State private var path = NavigationPath()
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack(path: $path) {
            SignUpView(signUpData: signUpData, path: $path)
                .navigationDestination(for: SignUpStep.self) { step in
                    switch step {
                    case .age:
                        AgeSelectionView(signUpData: signUpData, path: $path)
                    case .gender:
                        GenderSelectionView(signUpData: signUpData, path: $path)
                    case .height:
                        HeightSelectionView(signUpData: signUpData, path: $path)
                    case .weight:
                        WeightSelectionView(signUpData: signUpData, path: $path)
                    case .summary:
                        SummaryView(signUpData: signUpData)
                    case .email:
                        EmptyView()
                    }
                }
        }
    }
}

#Preview {
    SignUpWizardView()
}
