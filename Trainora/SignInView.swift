//
//  SignInView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI
import Combine

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    @State private var showInvalidCredentialsAlert = false

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userSession: UserSession
    @State private var cancellables = Set<AnyCancellable>()
    @State private var emailError: String?
    @State private var passwordError: String?


    @State private var userProfileService: UserProfileService =
        UserProfileService(
            repository: UserProfileRepository(
                dataSource: CoreDataUserProfileDataSource()
            )
        )

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
                    text: $email,
                    iconName: "person.fill"
                )
                .keyboardType(.emailAddress)
                .accessibilityIdentifier("emailTextField")

                StyledSecureField(
                    placeholder: "Password",
                    text: $password,
                    iconName: "lock.fill"
                )
                .accessibilityIdentifier("passwordSecureField")

                Button(action: {
                    handleSignIn()
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
                isPresented: $showInvalidCredentialsAlert
            ) {
                Button("OK", role: .cancel) {}
            }
        }
    }

    func handleSignIn() {
        guard !email.isEmpty, !password.isEmpty else {
            showInvalidCredentialsAlert = true
            return
        }

        userProfileService
            .getUserProfile(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { profile in
                if let profile = profile {
                    userSession.login(with: profile)
                    appState.isSignedIn = true
                    appState.loggedInUserName = profile.firstName
                } else {
                    showInvalidCredentialsAlert = true
                }
            }
            .store(in: &cancellables)
    }


}

#Preview {
    SignInView()
}
