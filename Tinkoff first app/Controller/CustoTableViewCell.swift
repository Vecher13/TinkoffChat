//
//  CustoTableViewCell.swift
//  Tinkoff first app
//
//  Created by Ash on 01.03.2021.
//

import UIKit



class CustoTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var themeManager = ThemesManager.shared.theme
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.textColor = themeManager?.labelTextColor
        messageLabel.textColor = themeManager?.subLabelTextColor
        timeLabel.textColor = themeManager?.subLabelTextColor
    }
    
    func configure(with model: ChatModel){
        guard let date = model.date else {return timeLabel.text = ""}
        if model.name != nil {
            nameLabel.text = model.name
        } else {
            nameLabel.text = "Some Person"
        }
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yy HH:mm"

       
        timeLabel.text = "\(formatter.string(from: date))"
       
//        if model.message == nil {
//            messageLabel.font = .italicSystemFont(ofSize: 14)
//            messageLabel.text = "No messages. It's time to start!"
//            timeLabel.text = nil
//        } else {
//            messageLabel.text = model.message?.last?.message
//        }
//
//        if model.online == true {
//            backgroundColor = #colorLiteral(red: 0.9962020516, green: 0.9977405667, blue: 0.8903076352, alpha: 1)
//        } else {
//            backgroundColor = .white
//        }
//
//        if model.hasUnreadMessages == false && model.message != nil {
//            messageLabel.font = .boldSystemFont(ofSize: 14)
//        } else if messageLabel != nil{
//
//            messageLabel.font = .systemFont(ofSize: 14)
//        }
//
//        if model.message == nil {
//            messageLabel.font = .italicSystemFont(ofSize: 14)
//            messageLabel.text = "No messages. It's time to start!"
//        }
        
        messageLabel.text = model.message?.last?.message
      
        
        
        
    }
    
    func settingsForCell(){
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
       
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
