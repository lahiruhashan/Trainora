//
//  NotificationsView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/1/25.
//

import CoreData
import SwiftUI

struct NotificationsView: View {
    @StateObject private var viewModel: NotificationsViewModel

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(
            wrappedValue: NotificationsViewModel(context: context)
        )
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.notifications.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "bell.slash.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("No Notifications")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 100)
                } else {
                    List(viewModel.notifications) { notification in
                        NotificationRow(notification: notification)
                            .onTapGesture {
                                viewModel.toggleSeen(notification)
                            }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !viewModel.notifications.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Clear All") {
                            viewModel.clearAll()
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchNotifications()
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceController.preview.container.viewContext
        NotificationsView(context: ctx)
    }
}
