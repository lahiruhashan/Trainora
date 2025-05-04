//
//  ChangePasswordView.swift
//  Trainora
//
//  Created by user266021 on 5/4/25.
//


import SwiftUIstruct ChangePasswordView: View {    @State private var currentPassword = ""    @State private var newPassword = ""    @State private var confirmPassword = ""    var body: some View {        Form {            Section(header: Text("Current Password")) {                SecureField("Enter current password", text: $currentPassword)            }            Section(header: Text("New Password")) {                SecureField("New password", text: $newPassword)                SecureField("Confirm new password", text: $confirmPassword)            }            Button("Update Password") {                // Save to Core Data or validate            }            .disabled(newPassword != confirmPassword || newPassword.isEmpty)        }        .navigationTitle("Change Password")    }}