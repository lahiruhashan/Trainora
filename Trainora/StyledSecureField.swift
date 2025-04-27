//
//  StyledSecureField.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct StyledSecureField: View {
    var placeholder: String
    @Binding var text: String
    var iconName: String? = nil

    var body: some View {
        HStack {
            if let icon = iconName {
                Image(systemName: icon)
                    .foregroundColor(.blue)
            }
            
            SecureField(placeholder, text: $text)
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
    StyledSecureField(placeholder: "Password", text: .constant(""), iconName: "lock.fill")
}
