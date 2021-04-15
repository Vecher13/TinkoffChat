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
        
        nameLabel.text = nil
        messageLabel.text = nil
        timeLabel.text = nil
        //        avatarImage.image = nil
    }
    
    func configure(with model: ChannelBD) {
        guard let givenDate = model.lastActivity else {return}
        
        let date = givenDate
        let formater = DateFormatter()
        formater.timeStyle = .short
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            formater.dateStyle = .none
            timeLabel.text = formater.string(from: date)
        } else {
            formater.dateFormat = "dd MMMM"
            timeLabel.text = formater.string(from: date)
        }
        
        nameLabel.text = (model.name != "") ? model.name : "Some Channel"
        var sender: String {
            return "name"
        }
        messageLabel.text = (model.lastMessage != nil) ? model.lastMessage : "No messages"
    }
    
    func settingsForCell() {
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
