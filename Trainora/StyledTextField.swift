//
//  StyledTextField.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct StyledTextField: View {
    var placeholder: String
    @Binding var text: String
    var iconName: String? = nil // Optional leading icon

    var body: some View {
        HStack {
            if let icon = iconName {
                Image(systemName: icon)
                    .foregroundColor(.blue)
            }
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    StyledTextField(placeholder: "First Name", text: .constant(""), iconName: "person.fill")
}
