//
//  ThemesModel.swift
//  Tinkoff first app
//
//  Created by Ash on 09.03.2021.
//

import Foundation
import UIKit

struct Theme {

    static var backgroundColor:UIColor?
    static var buttonTextColor:UIColor?
    static var buttonBackgroundColor:UIColor?
    static var inBubbleColor: UIColor = .systemBlue
    static var outBubbleColor: UIColor = .systemGreen
    static var textColor: UIColor?
    
    static public func defaultTheme() {
        self.backgroundColor = UIColor.white
        self.buttonTextColor = UIColor.blue
        self.buttonBackgroundColor = UIColor.white
        updateDisplay()
    }

    static public func darkTheme() {
//        self.backgroundColor = UIColor.darkGray
        self.buttonTextColor = UIColor.white
//        self.buttonBackgroundColor = UIColor.black
        self.backgroundColor = .black
        self.inBubbleColor = #colorLiteral(red: 0.1803726554, green: 0.1804046035, blue: 0.1803657115, alpha: 1)
        self.outBubbleColor = #colorLiteral(red: 0.3607498705, green: 0.3608063161, blue: 0.3607375622, alpha: 1)
        self.textColor = .brown
        
        
        updateDisplay()
    }

    static public func updateDisplay() {
        let proxyButton = UIButton.appearance()
//        proxyButton.setTitleColor(Theme.buttonTextColor, for: .normal)
//        proxyButton.backgroundColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
     
        let custom = CustomView.appearance()
        custom.backgroundColor = backgroundColor
        
        
        let proxyTable = UITableView.appearance()
        proxyTable.backgroundColor = backgroundColor
        
        let cell = UICollectionViewCell.appearance()
        cell.contentView.backgroundColor = backgroundColor
        
        let proxyTableCell = UITableViewCell.appearance()
        proxyTableCell.contentView.tintColor = backgroundColor
        proxyTableCell.backgroundView?.backgroundColor = backgroundColor
        proxyTableCell.contentView.tintColorDidChange()
        
        let proxyLabel = UILabel.appearance()
        proxyLabel.textColor = textColor
        
        
        let proxyView = UIView.appearance()
        
//        proxyView.backgroundColor = backgroundColor
    }
}
