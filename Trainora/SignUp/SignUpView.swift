//
//  SignUpEmailPasswordView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordAgain = ""

    @State private var showAlert = false
    @State private var alertMessage = ""

    @ObservedObject var signUpData: SignUpData
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            AppTitleView()
            Text("Create Account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            StyledTextField(
                placeholder: "First Name", text: $firstName,
                iconName: "person.fill")

            StyledTextField(
                placeholder: "Last Name", text: $lastName,
                iconName: "person.fill")

            StyledTextField(
                placeholder: "Email", text: $email, iconName: "envelope.fill"
            )
            .keyboardType(.emailAddress)

            StyledSecureField(
                placeholder: "Password", text: $password, iconName: "lock.fill")

            StyledSecureField(
                placeholder: "Confirm Password", text: $passwordAgain,
                iconName: "lock.rotation")

            Button(action: {
                if firstName.isEmpty || lastName.isEmpty || email.isEmpty
                    || password.isEmpty || passwordAgain.isEmpty
                {
                    alertMessage = "Please fill out all fields."
                    showAlert = true
                } else if password != passwordAgain {
                    alertMessage = "Passwords do not match."
                    showAlert = true
                } else {
                    signUpData.firstName = firstName
                    signUpData.lastName = lastName
                    signUpData.email = email
                    signUpData.password = password
                    onContinue()
                }
            }) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"), message: Text(alertMessage),
                dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    SignUpView(
        signUpData: SignUpData(),
        onContinue: {

        }  // Dummy model instance
        //        path: .constant(NavigationPath())  // Dummy binding
    )
}
