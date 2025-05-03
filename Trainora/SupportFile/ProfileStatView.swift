//
//  ProfileStatView.swift
//  Trainora
//
//  Created by user266021 on 5/3/25.
//


import SwiftUIstruct ProfileStatView: View {    var value: String    var label: String    var body: some View {        VStack(spacing: 4) {            Text(value)                .font(.headline)                .foregroundColor(.white)            Text(label)                .font(.caption)                .foregroundColor(.white.opacity(0.8))        }        .frame(maxWidth: .infinity)        .padding()        .background(Color.blue)        .cornerRadius(10)    }}