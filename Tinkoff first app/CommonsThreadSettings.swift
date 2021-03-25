//
//  CommonsThreadSettings.swift
//  Tinkoff first app
//
//  Created by Ash on 19.03.2021.
//

import Foundation
import UIKit

public enum UoloadOperationError: Error {
    case badOperationFinnished
    case badLoading
   
}

func dataLoad(data: UserPofile, completion: @escaping (Result<String, Error>) -> Void) {
    
    if let jsonData = try? JSONEncoder().encode(data) {
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            
            do {
                
                try jsonData.write(to: pathWithFilename, options: .atomic)
                if String(data: jsonData, encoding: .utf8) != nil {
                    completion(.success("Успех!"))
                }
            } catch {
                
                completion(.failure(UoloadOperationError.badLoading))
                print("Not today", error)
            }
        }
        
        // read
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            
            guard let data2 = try? Data(contentsOf: pathWithFilename) else { return }
            //        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            do {
                let userInfo = try JSONDecoder().decode(UserPofile.self, from: data2)
                print("User info is Here", userInfo.name, userInfo.info)
            } catch {
                
                print("Some erroes...", error)
            }
            
        }
        
    }
    
}

func readData(completion: @escaping (Result<UserPofile, Error>) -> Void) {
        // read
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            
            guard let data2 = try? Data(contentsOf: pathWithFilename) else { return }
            //        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            do {
                let userInfo = try JSONDecoder().decode(UserPofile.self, from: data2)
                completion(.success(userInfo))
                print("User info is Here", userInfo.name, userInfo.info)
            } catch {
                completion(.failure(UoloadOperationError.badLoading))
                print("Some erroes...", error)
            }
            
        }
        
}
