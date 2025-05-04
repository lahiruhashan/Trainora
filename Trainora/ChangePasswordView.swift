//
//  ChangePasswordView.swift
//  Trainora
//
//  Created by user266021 on 5/4/25.
//


import SwiftUIstruct ChangePasswordView: View {    @EnvironmentObject var colorSchemeManager: ColorSchemeManager    @State private var oldPassword = ""    @State private var newPassword = ""    @State private var confirmPassword = ""    @State private var passwordChanged = false    var body: some View {        Form {            Section(header: Text("Current Password")) {                SecureField("Old Password", text: $oldPassword)            }            Section(header: Text("New Password")) {                SecureField("New Password", text: $newPassword)                SecureField("Confirm Password", text: $confirmPassword)            }            Button("Save Password") {                if !oldPassword.isEmpty && newPassword == confirmPassword {                    passwordChanged = true                    // Save password in Core Data                }            }            .disabled(newPassword.isEmpty || confirmPassword.isEmpty || newPassword != confirmPassword)        }        .navigationTitle("Change Password")        .alert("Password Updated", isPresented: $passwordChanged) {            Button("OK", role: .cancel) { }        }    }}