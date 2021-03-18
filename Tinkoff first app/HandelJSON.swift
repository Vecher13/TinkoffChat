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
    let nameUser = "Alisa"
    let info = "STPP"
    let someData = UserPofile.init(name: "Asgg", info: "I'm a programmer!")
    
    func saveData(name: String, info: String) {
        jsonData = .init(name: name, info: info)
        let path = Bundle.main.path(forResource: "jsonData", ofType: "json")
        print(path as Any)
        
        let url = URL(fileURLWithPath: path!)
        print(url)
        
        let data = try! Data(contentsOf: url)
//        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        
        do {
            let userInfo = try JSONDecoder().decode(UserPofile.self, from: data)
            print("User info is Here", userInfo.name)
        } catch {
            print("Some erroes...", error)
        }
        
        
        
        
        
        //save
//        print(obj)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? JSONEncoder().encode(self.someData) {
            
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            
            
   
            }
            
            
            // read new
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            
            let data2 = try! Data(contentsOf: pathWithFilename)
    //        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            
            do {
                let userInfo = try JSONDecoder().decode(UserPofile.self, from: data2)
                print("User info is Here", userInfo.name, userInfo.info)
            } catch {
                print("Some erroes...", error)
            }
            
            
            }
        }
        
  
        //save
        let str = self.nameUser
        let dict = NSMutableDictionary()
        dict.setValue(str, forKey: "")
        dict.write(to: url, atomically: true)
        
        
        //save ver 2
        
        
    }
}
