//
//  AppNotification.swift
//  Trainora
//
//  Created by user266021 on 5/6/25.
//

import Foundation

struct AppNotification: Identifiable, Codable {
    let id: UUID
    let type: AppNotificationType
    let title: String
    let body: String
    let date: Date
    var isSeen: Bool
}
