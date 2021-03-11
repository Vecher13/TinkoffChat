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
    var traillingConstraint: NSLayoutConstraint?
    var leadingConstraints: NSLayoutConstraint?
    

    
    var message: Message?
    var themeManager = ThemesManager.shared.theme
    
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
    func configCell(with mesage: Message){
        guard let text = message?.message else {
            return
        }
        textMessageLabel?.text = text
    }
    
    func updateMessageCell(by message: Message){
        
        backgroundColor = themeManager?.backgroundColor
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        traillingConstraint = bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        leadingConstraints = bubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        textMessageLabel.text = message.message
        if message.fromMe == true{
            bubbleView.backgroundColor = themeManager?.outBabbleColor
            traillingConstraint?.isActive = true
            textMessageLabel.textAlignment = .right
        } else {
            bubbleView.backgroundColor = themeManager?.inBabbleColor
            leadingConstraints?.isActive = true
            textMessageLabel.textAlignment = .left
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
