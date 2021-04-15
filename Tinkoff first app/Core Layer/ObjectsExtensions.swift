//
//  ObjectsExtensions.swift
//  Tinkoff first app
//
//  Created by Ash on 30.03.2021.
//

import Foundation
import CoreData
import Firebase

extension ChannelBD {
    convenience init(name: String,
                     identifier: String,
                     lastActivity: Timestamp?,
                     lastMessage: String?,
                     in context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.identifier = identifier
        self.lastActivity = lastActivity?.dateValue()
        self.lastMessage = lastMessage
    }
//    var about: String {
//    let desctiption = "Имя канала '\(String(describing: name))'"
//        let messages = self.messageBD?.allObjects
//            .compactMap {$0 as? MessageBD}
//            .map { "\t\t\t\t\($0.about)" }
//            .joined(separator: "\n") ?? ""
//        return desctiption + messages
//    }
    
}

extension MessageBD {
    convenience init(content: String?,
                     created: Timestamp?,
                     identifier: String?,
                     senderId: String?,
                     senderName: String?,
                     in context: NSManagedObjectContext) {
        self.init(context: context)
        self.content = content
        self.created = created?.dateValue()
        self.identifier = identifier
        self.senderId = senderId
        self.senderName = senderName
    }
    
    var about: String {
        return "message(Сообщение): \(String(describing: content))"
    }
}

struct ChatRequest {
    let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func makeRequest(channal: Channel) {
        coreDataStack.performSave { (context) in
            _ = ChannelBD(name: channal.name, identifier: channal.identifier, lastActivity: channal.lastActivity, lastMessage: channal.lastMessage, in: context)
            
        }
    }
    
}
