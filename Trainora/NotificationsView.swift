//
//  NotificationsView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/1/25.
//

import CoreData
import SwiftUI
import UserNotifications

struct NotificationsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: NotificationEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \NotificationEntity.date,
                ascending: false
            )
        ],
        animation: .default
    )
    private var notifications: FetchedResults<NotificationEntity>

    var body: some View {
        NavigationStack {
            Group {
                if notifications.isEmpty {
                    // Empty state
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
                    // List of notifications
                    List {
                        ForEach(notifications) { entity in
                            // Safely unwrap id & date
                            if let id = entity.id,
                                let date = entity.date,
                                let typeRaw = entity.type,
                                let type = AppNotificationType(
                                    rawValue: typeRaw
                                )
                            {
                                let model = NotificationModel(
                                    id: id,
                                    type: type,
                                    title: entity.title ?? "",
                                    body: entity.body ?? "",
                                    date: date,
                                    isSeen: entity.isSeen
                                )
                                NotificationRow(notification: model)
                                    .onTapGesture {
                                        entity.isSeen.toggle()
                                        saveContext()
                                    }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !notifications.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Clear All") {
                            clearEverything()
                        }
                    }
                }
            }
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context:", error)
        }
    }

    private func clearEverything() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()

        // Delete each managed object so @FetchRequest updates immediately
        for obj in notifications {
            viewContext.delete(obj)
        }
        saveContext()
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceController.preview.container.viewContext
        NotificationsView()
            .environment(\.managedObjectContext, ctx)
    }
}
