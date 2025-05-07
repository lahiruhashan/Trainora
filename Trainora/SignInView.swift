//
//  SignInView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel

    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                AppTitleView()

                Text("Sign In")
                    .font(.title)
                    .foregroundStyle(Color.blue)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                StyledTextField(
                    placeholder: "Email",
                    text: $viewModel.email,
                    iconName: "person.fill"
                )
                .keyboardType(.emailAddress)
                .accessibilityIdentifier("emailTextField")

                StyledSecureField(
                    placeholder: "Password",
                    text: $viewModel.password,
                    iconName: "lock.fill"
                )
                .accessibilityIdentifier("passwordSecureField")

                Button(action: {
                    viewModel.handleSignIn()
                }) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                .accessibilityIdentifier("signInButton")

                Spacer()

                Button(action: {
                    showSignUp = true
                }) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 30)
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpWizardView()
                }
                .accessibilityIdentifier("signUpButton")
            }
            .padding()
            .alert(
                "Invalid Email or Password",
                isPresented: $viewModel.showInvalidCredentialsAlert
            ) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel(
        userProfileService: UserProfileService(
            repository: UserProfileRepository(
                dataSource: CoreDataUserProfileDataSource()
            )
        ),
        userSession: UserSession(),
        appState: AppState()
    ))
}
