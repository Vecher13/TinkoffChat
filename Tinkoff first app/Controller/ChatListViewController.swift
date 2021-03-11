//
//  ChatListViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 01.03.2021.
//

import UIKit



class ChatListViewController: UIViewController {
   
    @IBOutlet var barButton: UIBarButtonItem!
    
    let themeManager = ThemesManager.shared.theme
    
    let cellColor = ThemesManager.shared.theme?.subLabelTextColor
    let nameColor = ThemesManager.shared.theme?.labelTextColor
    var chatMod: ChatModel?
    
    var online: [ChatModel] = []
    var offline: [ChatModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        barButton.image = #imageLiteral(resourceName: "UserImage")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        filteringOnline()
        tableView.delegate = self
        tableView.backgroundColor = themeManager?.backgroundColor
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private let cellIdentifier = String(describing: CustoTableViewCell.self)
    

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

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
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "Online" : "History"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? online.count : offline.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chat: ChatModel
        chat = indexPath.section == 0 ? online[indexPath.row] : offline[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        secondVC.messages = chat.message
        if chat.name != nil {
        secondVC.title = chat.name
        } else {
            secondVC.title = "Chat with Incognito"
        }
        show(secondVC, sender: nil)
//        present(secondVC, animated: true, completion: nil)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
       
         var chat: ChatModel
        chat = indexPath.section == 0 ? online[indexPath.row] : offline[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustoTableViewCell else {return UITableViewCell()}
//        if chat.online == true {
        //            cell.backgroundColor = #colorLiteral(red: 0.9962020516, green: 0.9977405667, blue: 0.8903076352, alpha: 1)
        //        } else {
        //            cell.backgroundColor = .white
        //        }
        //
        //        if chat.hasUnreadMessages == false && chat.message != nil {
        //            cell.messageLabel.font = .boldSystemFont(ofSize: 14)
        //        } else if cell.messageLabel != nil{
        //
        //            cell.messageLabel.font = .systemFont(ofSize: 14)
        //        }
        //
        //        if chat.message == nil {
        //            cell.messageLabel.font = .italicSystemFont(ofSize: 14)
        //            cell.messageLabel.text = "No messages. It's time to start!"
        //        }
      
        cell.configure(with: .init(name: chat.name, message: chat.message, date: chat.date, online: chat.online, hasUnreadMessages: chat.hasUnreadMessages))
        cell.settingsForCell()
        
        let themeManager = ThemesManager.shared.theme
        cell.nameLabel.textColor = themeManager?.labelTextColor
        cell.messageLabel.textColor = themeManager?.subLabelTextColor
        cell.timeLabel.textColor =  themeManager?.subLabelTextColor
        cell.backgroundColor = themeManager?.backgroundColor
        
        
        
        return cell
    }
    private func filteringOnline(){
        online = chatList.filter({$0.online == true})
        offline = chatList.filter({$0.online == false && $0.message != nil})
        
        tableView.reloadData()
    }
    
}
