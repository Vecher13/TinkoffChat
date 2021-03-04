//
//  MessageTableViewCell.swift
//  Tinkoff first app
//
//  Created by Ash on 04.03.2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet var textMessageLabel: UILabel!
    @IBOutlet var bubbleView: UIView!
    var traillingConstraint: NSLayoutConstraint?
    var leadingConstraints: NSLayoutConstraint?
    

    
    var message: Message?
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        traillingConstraint = bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        leadingConstraints = bubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        textMessageLabel.text = message.message
        if message.fromMe == true{
            bubbleView.backgroundColor = .systemBlue
            traillingConstraint?.isActive = true
            textMessageLabel.textAlignment = .right
        } else {
            bubbleView.backgroundColor = .systemGreen
            leadingConstraints?.isActive = true
            textMessageLabel.textAlignment = .left
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
