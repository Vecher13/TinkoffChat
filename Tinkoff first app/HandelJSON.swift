//
//  HandelJSON.swift
//  Tinkoff first app
//
//  Created by Ash on 16.03.2021.
//

import Foundation
import UIKit

struct UserPofile: Codable {
    internal init(name: String, info: String) {
        self.name = name
        self.info = info
    }
    
    var name: String
    var info: String
}

class SaveDataManager {
   
    var jsonData: UserPofile?
    
    func saveData(name: String, info: String) {
        jsonData = .init(name: name, info: info)
        let path = Bundle.main.path(forResource: "jsonData", ofType: "json")
        print(path as Any)
        
        let url = URL(fileURLWithPath: path!)
        print(url)
        
        guard  let data = try? Data(contentsOf: url) else {return}
//        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        do {
            let userInfo = try JSONDecoder().decode(UserPofile.self, from: data)
            print("User info is Here", userInfo.name)
        } catch {
            print("Some erroes...", error)
        }
        
    }
}
