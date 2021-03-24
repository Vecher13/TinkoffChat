//
//  CustoTableViewCell.swift
//  Tinkoff first app
//
//  Created by Ash on 01.03.2021.
//

import UIKit
import Firebase


class CustoTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var themeManager = ThemesManager.shared.theme
    let id = UIDevice.current.identifierForVendor!.uuidString
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        //        nameLabel.textColor = themeManager?.labelTextColor
        //        messageLabel.textColor = themeManager?.subLabelTextColor
        //        timeLabel.textColor = themeManager?.subLabelTextColor
        nameLabel.text = nil
        messageLabel.text = nil
        timeLabel.text = nil
        //        avatarImage.image = nil
    }
    
    func configure(with model: Channel)
    {
        
        nameLabel.text = (model.name != nil) ? model.name : "Some Persone"
        //        guard model.date != nil else {return timeLabel.text = ""}
        //        if model.name != nil {
        //            nameLabel.text = model.name
        //        } else {
        //            nameLabel.text = "Some Person"
        //        }
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yy HH:mm"
        timeLabel.text = (model.lastActivity != nil) ? formatter.string(from: model.lastActivity?.dateValue() ?? Date.init(timeIntervalSince1970: 1)) : ""
        //        timeLabel.text = "\(formatter.string(from: date))"
        var sender: String{
            return "name"
        }
        messageLabel.text = (model.lastMessage != nil) ? model.lastMessage : "No messages"
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
        
        //        messageLabel.text = model.message?.last?.message
        
        
        
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
