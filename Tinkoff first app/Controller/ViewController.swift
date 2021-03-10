//
//  ViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 13.02.2021.
//

import UIKit

class ViewController: UIViewController {

    
    
    let logVC = LogController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view = CustomView()
        
        logVC.showLog(function: #function, for: .view)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logVC.showLog(function: #function, for: .view)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVC.showLog(function: #function, for: .view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVC.showLog(function: #function, for: .view)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVC.showLog(function: #function, for: .view)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logVC.showLog(function: #function, for: .view)
        
    }


}

