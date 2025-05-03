//
//  SignUpData.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import Foundation

class SignUpData: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var gender: String = ""
    @Published var age: Int = 18
    @Published var height: Double = 170
    @Published var weight: Double = 65
}

