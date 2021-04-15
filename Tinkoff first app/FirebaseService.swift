//
//  FirebaseService.swift
//  Tinkoff first app
//
//  Created by Ash on 14.04.2021.
//

import Foundation
import Firebase
import CoreData
import UIKit

// protocol UpdateChannenDataProtocl{
//    func updateChannelData(
// }

class FirebaseService {
    static let shared = FirebaseService()
    lazy var db = Firestore.firestore()
    let modernCoreDataStack = ModernCoreDataStack()
    lazy var channels = db.collection("channels")
    var channelsList = [Channel]()

    func getChannelsList() {
        
        channels.addSnapshotListener { (snapshot, err) in
            self.channelsList = []
            if let err = err {
                print("Error getting data", err)
            } else {
              
                snapshot?.documents.forEach({ (document) in
                    let data = document.data()
                    
                    if let identifier = document.documentID as String?,
                       let name1 = data["name"] as? String,
                       let lastMessage = data["lastMessage"] as? String?,
                       let lastActivity = data["lastActivity"] as? Timestamp? {
                        let newChannel = Channel(identifier: identifier, name: name1, lastMessage: lastMessage, lastActivity: lastActivity, document: document)

                        self.channelsList += [newChannel]
                        
                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
                           
                        }
                    }
                }
                )
            }
           
            guard let snapshot = snapshot else {return}
            snapshot.documentChanges.forEach { diff in
                              if diff.type == .added {
                                  print("New channel!: \(diff.document.data())")
                              }
                              if diff.type == .modified {
                                  print("Modified channel: \(diff.document.data())")
                              }
                              if diff.type == .removed {
                                let request: NSFetchRequest<ChannelBD> = ChannelBD.fetchRequest()
                                
                                request.predicate = NSPredicate(format: "identifier == %@", "\(diff.document.documentID)")
                                var result: [ChannelBD] = []
                                let context = self.modernCoreDataStack.container.viewContext
                                do {
                                    result = try  context.fetch(request)
                                } catch {
                                    print(error)
                                }
//
                                context.delete(result[0])
                                self.modernCoreDataStack.saveContext()
                                print("Removed channel: \(diff.document.documentID)")
                              }
                          }
        
            print("count channels: ", self.channelsList.count)
            DispatchQueue.global().async {
                self.saveCoreData(data: self.channelsList)
            }
            
        }
        
    }
    fileprivate func saveCoreData(data: [Channel]) {
        data.forEach { (channel) in
            
            self.modernCoreDataStack.container.performBackgroundTask { context in
                _ = ChannelBD(name: channel.name,
                                           identifier: channel.identifier,
                                           lastActivity: channel.lastActivity,
                                           lastMessage: channel.lastMessage,
                                           in: context)
                
                do {
                    context.automaticallyMergesChangesFromParent = true
                    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                    try context.save()
                  } catch {
                    // handle error
                    print(error)
                  }
            }
            
        }
    }
    
    func createChannel(name: String?) {
        if let name = name {
        db.collection("channels").addDocument(data: ["name": name,
                                                     "lastActivity": Timestamp()
        ]) {(error) in
            if let err = error {
                print("Can't send the message", err)
            }
            
        }
        }
    }
    
    func addChannel() {
        let alert = UIAlertController(title: "Создать новый канал", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Введите имя канала"
        }
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: {[weak alert] _ in
            guard let textField = alert?.textFields else {return}
            if textField[0].text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                guard let text = textField[0].text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
                self.createChannel(name: text)
            } else {
                print("No channel's name")
                self.allertError()
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
    
//        self.present(alert, animated: true)
    }
    func allertError() {
        let alert = UIAlertController(title: "Введите имя канала", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.addChannel()
            
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
//        self.present(alert, animated: true)
    }
}
