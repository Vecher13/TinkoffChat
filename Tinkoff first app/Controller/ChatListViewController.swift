//
//  ChatListViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 01.03.2021.
//

import UIKit
import Firebase

class ChatListViewController: UIViewController {
   
    @IBOutlet var barButton: UIBarButtonItem!
    @IBOutlet var addChannelButton: UIBarButtonItem!

    let themeManager = ThemesManager.shared.theme
    
    lazy var db = Firestore.firestore()
    lazy var channels = db.collection("channels").order(by: "lastActivity", descending: true)
    
    let cellColor = ThemesManager.shared.theme?.subLabelTextColor
    let nameColor = ThemesManager.shared.theme?.labelTextColor
   
    var channelsList = [Channel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getChannelsList()
       
        view.addSubview(tableView)
        barButton.image = #imageLiteral(resourceName: "UserImage")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = themeManager?.backgroundColor
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        view.reloadInputViews()
    }
    
    @IBAction func addChannel(_ sender: Any) {
        addChannel()
    }

    private let cellIdentifier = String(describing: CustoTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.register(UINib(nibName: String(describing: CustoTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        
        return tableView
    }()

}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var chat: Channel?
       chat = channelsList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustoTableViewCell else {return UITableViewCell()}
        if let chat = chat {
        cell.configure(with: chat)
        
        cell.settingsForCell()
        }
        let themeManager = ThemesManager.shared.theme
        cell.nameLabel.textColor = themeManager?.labelTextColor
        cell.messageLabel.textColor = themeManager?.subLabelTextColor
        cell.timeLabel.textColor = themeManager?.subLabelTextColor
        cell.backgroundColor = themeManager?.backgroundColor
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chat: Channel
        chat = channelsList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        secondVC.documentID = chat.identifier
        secondVC.title = chat.name
        show(secondVC, sender: nil)
//        present(secondVC, animated: true, completion: nil)
        
    }
    
}

extension ChatListViewController {
    
    func getChannelsList() {
        
        channels.addSnapshotListener { (snapshot, err) in
            self.channelsList = []
            if let err = err {
                print("Error getting data", err)
            } else {
              
                snapshot?.documents.forEach({ (document) in
                    let data = document.data()
                    print(document.documentID)
                    print(data)
                    if let identifier = document.documentID as String?,
                       let name1 = data["name"] as? String,
                       let lastMessage = data["lastMessage"] as? String?,
                       let lastActivity = data["lastActivity"] as? Timestamp? {
                        let newChannel = Channel(identifier: identifier, name: name1, lastMessage: lastMessage, lastActivity: lastActivity)
//                        print("123", newChannel)
                        self.channelsList += [newChannel]
//                        print("infolist", self.channelsList.count)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
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
            if let text = textField[0].text {
                self.createChannel(name: text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)

    }
}
