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
    var traillingConstraint: NSLayoutConstraint?
    var leadingConstraints: NSLayoutConstraint?
    
    var themeManager = ThemesManager.shared.theme
    
    let id = UIDevice.current.identifierForVendor!.uuidString
    
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
        } else {
            bubbleView.backgroundColor = themeManager?.inBabbleColor
            leadingConstraints?.isActive = true
            textMessageLabel.textAlignment = .left
            senderName.text = message.senderName
            senderName.textAlignment = .left
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
