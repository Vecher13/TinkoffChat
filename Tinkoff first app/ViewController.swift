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
        logVC.showLog(function: #function)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logVC.showLog(function: #function)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVC.showLog(function: #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVC.showLog(function: #function)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVC.showLog(function: #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logVC.showLog(function: #function)
        
    }


}

