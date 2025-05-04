//
//  SignInView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                AppTitleView()
                
                Text("Sign In")
                    .font(.title)
                    .foregroundStyle(Color.blue)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                StyledTextField(placeholder: "Email", text: $email, iconName: "person.fill")
                    .keyboardType(.emailAddress)

                StyledSecureField(placeholder: "Password", text: $password, iconName: "lock.fill")

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
            }
            .padding()
        }
    }
    
    func handleSignIn() {
        if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            print("📍 Core Data DB location: \(url)")
        }
            print("Signed in with: \(email)")
            appState.isSignedIn = true  // ✅ Navigates to Home screen
        }
    
    
}



#Preview {
    SignInView()
}
