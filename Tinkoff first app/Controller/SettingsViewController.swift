//
//  SettingsViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 09.03.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var classicView: UIView!
    @IBOutlet var dayView: UIView!
    @IBOutlet var nightView: UIView!
    @IBOutlet var classicLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var nigthLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupGestures()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        classicView.layer.cornerRadius = 14
        dayView.layer.cornerRadius = 14
        nightView.layer.cornerRadius = 14
    }

    @objc func classicTap(_ sender: UITapGestureRecognizer) {
        Theme.defaultTheme()
        self.loadView()
        print("classic selected")
    }
    
    @objc func dayTap(_ sender: UITapGestureRecognizer) {
        print("day selected")
    }
    
    @objc func nightTap(_ sender: UITapGestureRecognizer) {
        Theme.darkTheme()
        self.loadView()
        print("night selected")
    }
    
    
    func setupGestures(){
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
    

}


