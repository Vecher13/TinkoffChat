//
//  Networking.swift
//  Tinkoff first app
//
//  Created by Ash on 20.04.2021.
//

import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    var imageCache = NSCache<NSString, UIImage>()
    
    func getURL(url: URL, completion: @escaping (Result<[ImageURL], Error>) -> Void) {
        let request = URLRequest(url: url, timeoutInterval: 5)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(ResponseData.self, from: data)
                    
                    completion(.success(response.hits))
                    print("asdasd", response.hits.count)
                    
                } catch let error as NSError {
                    completion(.failure(error))
                    print("Faild to load: \(error.localizedDescription)")
                }
            } else {
                print("no data")
            }
            
        }
        task.resume()
    }
    
    func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else {return}
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            
                completion(cachedImage)
                print("SUCCESS TO TAKE IMAGE", cachedImage)
            
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 5)
            let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                
                guard error == nil,
                      data != nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let `self` = self else {
                    return
                }
                guard let data = data else {return}
                guard let image = UIImage(data: data) else {return}
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
           
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image)
                
                }
            }
            dataTask.resume()
        }
        
    }
    
}
