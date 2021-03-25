//
//  SettingsViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 09.03.2021.
//

import UIKit

// --------

class SettingsViewController: UIViewController {
    @IBOutlet var classicView: UIView!
    @IBOutlet var dayView: UIView!
    @IBOutlet var nightView: UIView!
    @IBOutlet var classicLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var nigthLabel: UILabel!
    
    var theme: Theme12?
    var themeManager = ThemesManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        classicView.layer.cornerRadius = 14
        classicView.layer.borderWidth = 1
        dayView.layer.cornerRadius = 14
        dayView.layer.borderWidth = 1
        nightView.layer.cornerRadius = 14
        nightView.layer.borderWidth = 1
        
        view.backgroundColor = themeManager.theme?.backgroundColor
    }
    
    @objc func classicTap(_ sender: UITapGestureRecognizer) {
        themeManager.setTheme(theme: ClassicTheme())
        reloadViews()
        classicView.layer.borderWidth = 2
        classicView.layer.borderColor = #colorLiteral(red: 0.03566086292, green: 0.2021744251, blue: 0.998301208, alpha: 1)
        
        dayView.layer.borderWidth = 1
        nightView.layer.borderColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
        nightView.layer.borderWidth = 2
        
        dayView.layer.borderColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
        print("classic selected")
    }
    
    @objc func dayTap(_ sender: UITapGestureRecognizer) {
        
        themeManager.setTheme(theme: DayTheme())
        reloadViews()
        
        dayView.layer.borderWidth = 2
        dayView.layer.borderColor = #colorLiteral(red: 0.03566086292, green: 0.2021744251, blue: 0.998301208, alpha: 1)
        
        nightView.layer.borderColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
        nightView.layer.borderWidth = 1
        classicView.layer.borderWidth = 1
        classicView.layer.borderColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
        
        print("day selected")
    }
    
    @objc func nightTap(_ sender: UITapGestureRecognizer) {
        
        themeManager.setTheme(theme: NightTheme())
        reloadViews()
        
        dayView.layer.borderWidth = 1
        nightView.layer.borderColor = #colorLiteral(red: 0.03566086292, green: 0.2021744251, blue: 0.998301208, alpha: 1)
        nightView.layer.borderWidth = 2
        classicView.layer.borderWidth = 1
        classicView.layer.borderColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
        dayView.layer.borderColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().tintColor = .yellow
        
        print("night selected")
    }
    
    func setupGestures() {
        let classicViewGesture = UITapGestureRecognizer(target: self, action: #selector(classicTap(_:)))
        classicView.addGestureRecognizer(classicViewGesture)
        
        let classicLabelGesture = UITapGestureRecognizer(target: self, action: #selector(classicTap(_:)))
        classicLabel.addGestureRecognizer(classicLabelGesture)
        
        let dayViewGesture = UITapGestureRecognizer(target: self, action: #selector(dayTap(_:)))
        dayView.addGestureRecognizer(dayViewGesture)
        
        let dayLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dayTap(_:)))
        dayLabel.addGestureRecognizer(dayLabelGesture)
        
        let nightViewGesture = UITapGestureRecognizer(target: self, action: #selector(nightTap(_:)))
        nightView.addGestureRecognizer(nightViewGesture)
        
        let nightLabelGesture = UITapGestureRecognizer(target: self, action: #selector(nightTap(_:)))
        nigthLabel.addGestureRecognizer(nightLabelGesture)
        
    }
    func reloadViews() {
        view.backgroundColor = ThemesManager.shared.theme?.backgroundColor
        UITableViewHeaderFooterView.appearance().backgroundColor = .blue
        
        UITableViewCell.appearance().backgroundColor = .gray
        //        containerView.backgroundColor = ThemesManager.shared.theme?.secondaryBackgroundColor
        //        headingLbl.textColor = ThemesManager.shared.theme?.heading
        //        subHeadingLbl.textColor = ThemesManager.shared.theme?.subHeading
        //        toggleButton.tintColor = ThemesManager.shared.theme?.tintColor
    }
}
