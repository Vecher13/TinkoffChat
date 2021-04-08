//
//  ChatViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 04.03.2021.
//

import UIKit
import Firebase
import CoreData

class ChatViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet var testView: UIView!
    @IBOutlet var textMessageField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    let coreDataStack = CoreDataStack()
    let modernCoreDataStack = ModernCoreDataStack()
    var message: Message?
    var messagesList = [Message]()
    var messageBd = [MessageBD]()
    var channelBD: ChannelBD?
    var channel: ChannelBD?
    var documentID: String?
    var myName: String?
    lazy var db = Firestore.firestore()
    let myId = UIDevice.current.identifierForVendor!.uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        loadMyProfileData()
      
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: testView.topAnchor).isActive = true
        tableView.separatorStyle = .none
        navigationItem.largeTitleDisplayMode = .never
       kB()
        hideKeyboardOnTapOnScren()
        tableView.delegate = self
        
        coreDataStack.didUpdateDataBase = { stack in
                    stack.printDatabaseStatistice()
                }
        
                coreDataStack.enableObservers()
        
        getMessage(documetnID: documentID)
    }
    
    lazy var fetchDataFormDB: NSFetchedResultsController<MessageBD> = {
        let request: NSFetchRequest<MessageBD> = MessageBD.fetchRequest()
        var context = modernCoreDataStack.container.viewContext
        context.automaticallyMergesChangesFromParent = true
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "identifier == %@", "\(String(describing: documentID))")
        
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: modernCoreDataStack.container.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            print(error)
        }
        
        return frc
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let newIndexPath = newIndexPath else {return}
            guard let indexPath = indexPath else {return}
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
        guard let indexPath = indexPath else {return}
        tableView.reloadRows(at: [indexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
        tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if textMessageField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
        sendMessage(documentID: documentID)
            print("Message was send")
        } else {
           print("need some text")
        }
    }
    
    private let cellIdentifier = String(describing: MessageTableViewCell.self)
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.register(UINib(nibName: String(describing: MessageTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        
        return tableView
    }()
    
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 49
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchDataFormDB.fetchedObjects else { return 0 }
        return section.count
//        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageBD = fetchDataFormDB.object(at: indexPath)
        
//        message = self.messagesList[indexPath.row]
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        
        cell.updateMessageCell(by: messageBD)
        
//        cell.textMessageLabel.text = messageBD.content
        
//        if let message = message {
//            cell.updateMessageCell(by: message)
//            cell.textMessageLabel.text = message.message
//
//        cell.contentView.backgroundColor = Theme.backgroundColor
//        } else {
//            print("Error send message to cell")
//        }
        return cell
    }
    
}

extension ChatViewController {
    func getMessage(documetnID: String?) {
         
        guard let iD = documentID else {return}
        
        let message = db.collection("channels").document(iD).collection("messages").order(by: "created")
        message.addSnapshotListener { [self] (documentSnapshot, error) in
            self.messagesList = []
//            self.coreDataStack.performSave { (context) in
//                guard let channel = self.channel else {return}
//                let cBD = ChannelBD(name: channel.name,
//                       identifier: channel.identifier,
//                       lastActivity: channel.lastActivity,
//                       lastMessage: channel.lastMessage,
//                       in: context)
//
//            }
//
//            var messagesBdArray: [MessageBD] = []
            if let error = error {
//                self.alert()
                print("Couldn't load message", error)
            } else {
                documentSnapshot?.documents.forEach({ (document) in
                    let identifier = document.documentID
                    if let content = document["content"] as? String,
                       let created = document["created"] as? Timestamp,
                       let senderId = document["senderId"] as? String,
                       let senderName = document["senderName"] as? String {
                        let newMessage = Message(content: content, created: created, senderId: senderId, senderName: senderName, identifire: identifier)
                        self.messagesList += [newMessage]
                        
//                       
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
//                            self.tableView.scrollToRow(at: [0, self.messagesList.count - 1], at: .bottom, animated: false)
                            
                        }
                    }
                    
                }
                )
            }
            saveCoreData(data: self.messagesList)
//            guard let document = documentSnapshot else {return}
//            for message in document.documents {
//            print("message: ", message.data())
//
//            }
          
//                self.sevaCoreData(data: self.messagesList)
//            saveCD(data: self.messageBd)
        }
        
    }
    
    func saveCoreData(data: [Message]) {
        data.forEach { (message) in
            _ = modernCoreDataStack.container.newBackgroundContext()
            let context = self.modernCoreDataStack.container.viewContext
                let messageBD = MessageBD(content: message.content,
                                          created: message.created,
                                          identifier: message.identifire,
                                          senderId: message.identifire,
                                          senderName: message.senderName,
                                          in: context)
                
//                guard let channel = self.channel else {return}

                let request: NSFetchRequest<ChannelBD> = ChannelBD.fetchRequest()
                request.predicate = NSPredicate(format: "identifier == %@", "\(String(describing: self.documentID))")
                var result: [ChannelBD] = []
                
                do {
                    result = try  context.fetch(request)
                } catch {
                    print(error)
                }
            guard let fetchedChannel = result.first else {return}
            fetchedChannel.addToMessageBD(messageBD)
            
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
    
    func sendMessage(documentID: String?) {
        guard let iD = documentID else {return}
        guard let name = myName else {return}
        let message = db.collection("channels").document(iD).collection("messages")
        if let messageBody = textMessageField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            message.addDocument(data: ["content": messageBody,
                                       "created": Timestamp(),
                                       "senderId": self.myId,
                                       "senderName": name
            ]) {(error) in
                if let err = error {
                    print("Can't send the message", err)
                } else {
                    self.textMessageField.text = ""
                    print("success")
                }
                
            }
        }
    }
    func loadMyProfileData() {
        GCDUploader().loadData { userData in
            switch userData {
            case .success(let data):
                self.myName = data.name
                
            case .failure:
                print("Could not read data")
            }
        }
    }
    
    func alert() {
        
            let alert = UIAlertController(title: "Проблемы с загрузгой", message: "Может еще раз?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Забить", style: .default, handler: {_ in
               self.dismiss(animated: true, completion: nil)
            
            }))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.getMessage(documetnID: self.documentID)
            
            }))
            self.present(alert, animated: true)
    }
    
}

extension ChatViewController {
    
    // MARK: - keyboard control
    
    func kB() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        else {
          // if keyboard size is not available for some reason, dont do anything
          return
        }
       
        additionalSafeAreaInsets.bottom = keyboardSize
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
      }

      @objc func keyboardWillHide(notification: NSNotification) {
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        // reset back the content inset to zero after keyboard is gone
        additionalSafeAreaInsets.bottom = 0
        
      }
    
    func hideKeyboardOnTapOnScren() {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
                   target: self,
                   action: #selector(self.dismissKeyboard))

               self.view.addGestureRecognizer(tapRecognizer)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
