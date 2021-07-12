//
//  GCDUploader.swift
//  Tinkoff first app
//
//  Created by Ash on 17.03.2021.
//

import Foundation
import UIKit

class GCDUploader {
    private let queue = DispatchQueue.global(qos: .utility)
    
    func uploadData(data: UserPofile, completion: @escaping (Result<String, Error>) -> Void) {
        queue.async {
            dataLoad(data: data) { result in
                DispatchQueue.main.async { completion(result) }
            }
        }
    }
    func loadData(completion: @escaping (Result<UserPofile, Error>) -> Void) {
        queue.async {
            readData { userData in
                DispatchQueue.main.async {
                    completion(userData)
                }
            }
        }
    }
}
