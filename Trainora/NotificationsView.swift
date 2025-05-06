//
//  NotificationsView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/1/25.
//

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var store: NotificationStore
    var body: some View {
        NavigationStack {
            VStack {
                if store.notifications.isEmpty {
                    emptyState

                } else {
                    List {
                        ForEach(store.notifications) { notification in
                            NotificationRow(notification: notification)
                                .onTapGesture {
                                    store.markAsSeen(notification)
                                }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Notifications")
            .toolbar {
                if !store.notifications.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Clear All") {
                            store.clearAll()
                        }
                    }
                }
            }
        }
    }
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "bell.slash.fill")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            Text("No Notifications")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .padding(.top, 100)
    }
}
