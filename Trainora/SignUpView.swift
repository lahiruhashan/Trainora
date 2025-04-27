//
//  SignUpEmailPasswordView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignUpEmailPasswordView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showDetailsScreen = false

    var body: some View {
        VStack(spacing: 20) {
            AppTitleView()
            Text("Create Account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                showDetailsScreen = true
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
        .navigationDestination(isPresented: $showDetailsScreen) {
            SignUpDetailsView()
        }
    }
}

#Preview {
    SignUpEmailPasswordView()
}
