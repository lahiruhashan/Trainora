//
//  ProfileView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/1/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: UserProfileViewModel

    init(user: UserProfile) {
           let service = UserProfileService(
               repository: UserProfileRepository(
                   dataSource: CoreDataUserProfileDataSource()
               )
           )
           _viewModel = StateObject(wrappedValue: UserProfileViewModel(service: service, userProfile: user))
    }

    private var formattedHeight: String {
        let height = viewModel.profile.height
        return height.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(height)) CM"
            : "\(String(format: "%.1f", height)) CM"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Top Title
                Text("My Profile")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .horizontal])

                // Profile Image
                Image(
                    uiImage: ImageStorage.loadImage(
                        named: viewModel.profile.profileImageName
                    )
                )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 4)

                // Name
                Text("\(viewModel.profile.firstName) \(viewModel.profile.lastName)")
                    .font(.title2.bold())
                
                // Email
                Text(viewModel.profile.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Birthday
                Text(
                    "Birthday: \(formattedDate(viewModel.profile.dateOfBirth))"
                )
                .font(.caption)
                .foregroundColor(.secondary)

                // Stats Row
                HStack(spacing: 12) {
                    ProfileStatView(
                        value: "\(Int(viewModel.profile.weight)) Kg",
                        label: "Weight"
                    )
                    ProfileStatView(
                        value: "\(viewModel.age) Years",
                        label: "Age"
                    )
                    ProfileStatView(value: formattedHeight, label: "Height")
                }
                .padding(.horizontal)

                // Experience Level as Card
                ProfileStatView(
                    value: viewModel.profile.experience.rawValue.capitalized,
                    label: "Experience Level"
                )
                .padding(.horizontal)

                Spacer()
            }
            // Edit Profile Button
            NavigationLink(destination: EditProfileView(viewModel: viewModel)) {
                Text("Edit Profile")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding([.horizontal, .bottom])
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
