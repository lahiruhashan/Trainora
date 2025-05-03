//
//  LabeledTextField.swift
//  Trainora
//
//  Created by user266021 on 5/3/25.
//


import SwiftUIstruct LabeledTextField: View {    var title: String    @Binding var text: String    var isSecure: Bool = false    var body: some View {        VStack(alignment: .leading, spacing: 6) {            Text(title)                .font(.subheadline)                .foregroundColor(.blue)                .padding(.horizontal)            Group {                if isSecure {                    SecureField(title, text: $text)                } else {                    TextField(title, text: $text)                }            }            .padding()            .background(Color(.systemGray6))            .cornerRadius(10)            .padding(.horizontal)        }    }}