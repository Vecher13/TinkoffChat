//
//  MessageTableViewCell.swift
//  Tinkoff first app
//
//  Created by Ash on 04.03.2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet var textMessageLabel: UILabel!
    @IBOutlet var bubbleView: UILabel!
    @IBOutlet var senderName: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var traillingConstraint: NSLayoutConstraint?
    var leadingConstraints: NSLayoutConstraint?
    
    var themeManager = ThemesManager.shared.theme
    
    let id = UIDevice.current.identifierForVendor?.uuidString
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        textMessageLabel.text = nil
        traillingConstraint?.isActive = false
        leadingConstraints?.isActive = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateMessageCell(by message: Message) {
        let date = Date(timeIntervalSince1970: Double(message.created.seconds))
        let formater = DateFormatter()
        formater.timeStyle = .short
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            formater.dateStyle = .none
            dateLabel.text = formater.string(from: date)
        } else {
            formater.dateFormat = "dd MMMM"
            dateLabel.text = formater.string(from: date)
        }
        
        backgroundColor = themeManager?.backgroundColor
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        traillingConstraint = bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        leadingConstraints = bubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        textMessageLabel.text = message.content
        if message.senderId == self.id {
            bubbleView.backgroundColor = themeManager?.outBabbleColor
            traillingConstraint?.isActive = true
            textMessageLabel.textAlignment = .right
            senderName.text = "You"
            senderName.textAlignment = .right
            dateLabel.textAlignment = .right
        } else {
            bubbleView.backgroundColor = themeManager?.inBabbleColor
            leadingConstraints?.isActive = true
            textMessageLabel.textAlignment = .left
            senderName.text = message.senderName
            senderName.textAlignment = .left
            dateLabel.textAlignment = .left
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
