//
//  AppTitleView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/27/25.
//

import SwiftUI

struct AppTitleView: View {
    @State private var animate = false

    var body: some View {
        Text("Trainora")
            .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.blue, Color.purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
            .padding(.bottom, 10)
//            .opacity(animate ? 1 : 0)  // Fade In
//            .offset(x: animate ? 0 : -30)  // Slide In from left
//            .animation(.easeOut(duration: 0.8), value: animate)
//            .onAppear {
//                animate = true
//            }
    }
}

#Preview {
    AppTitleView()
}
