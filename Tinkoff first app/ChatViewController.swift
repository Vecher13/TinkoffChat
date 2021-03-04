//
//  ChatViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 04.03.2021.
//

import UIKit

class ChatViewController: UIViewController {

    var messages: [Message]?
    var message: Message?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tableView.separatorStyle = .none
        
        
        tableView.delegate = self
        
        
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
        guard let messages = messages else {return 0}
         
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
       

        message = self.messages![indexPath.row]
        

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell else
        {return UITableViewCell()}
        if let message = message {
            cell.updateMessageCell(by: message)
//            cell.textMessageLabel.text = message.message
        }
        
        
        return cell
    }
    
    
}
