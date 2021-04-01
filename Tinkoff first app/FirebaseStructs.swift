//
//  FirebaseStructs.swift
//  Tinkoff first app
//
//  Created by Ash on 23.03.2021.
//

import Foundation
import Firebase

struct Channel {
let identifier: String
let name: String
let lastMessage: String?
let lastActivity: Timestamp?
}

struct Message {
let content: String
let created: Timestamp
let senderId: String
let senderName: String
    let identifire: String
}
