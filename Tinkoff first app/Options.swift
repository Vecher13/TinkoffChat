//
//  Options.swift
//  Tinkoff first app
//
//  Created by Ash on 18.03.2021.
//

import Foundation
import UIKit

class OperationUploader {
     let queue = OperationQueue()
    
    
    
    func uploadData(data: UserPofile, completion: @escaping (Result<String, Error>) -> Void) {
        
        let dataUploadOperation = DataUploadoadOperation(data: data)
//        let rotateImageOperation = RotateImageOperation(nil)
        
//        rotateImageOperation.addDependency(dataUploadOperation)
        
        dataUploadOperation.completionBlock = {
            OperationQueue.main.addOperation {
                if let result = dataUploadOperation.result {
                    completion(result)
                } else {
                    print("Uuuupsss...", UoloadOperationError.badLoading)
                }
            }
        }
        
        queue.addOperations([dataUploadOperation], waitUntilFinished: false)
    }
}

// MARK: AsyncOperation

class AsyncOperation: Operation {
    
    enum State: String {
        case ready, executing, finished, cancelled
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncOperation {
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isCancelled: Bool {
        return state == .cancelled
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        state = .cancelled
    }
}

// MARK: ImageLoadOperation

class DataUploadoadOperation: AsyncOperation {
//    private let url: URL
    private(set) var result: Result<String, Error>?
    private let data: UserPofile
    
    init(data: UserPofile) {
        self.data = data
        super.init()
    }
    
    override func main() {
        if isCancelled {
            state = .finished
            return
        }
        dataLoad(data: data) { [weak self] result in
            self?.result = result
            self?.state = .finished
        }
        
//        syncImageLoad(imageURL: url) { [weak self] result in
//            self?.result = result
//            self?.state = .finished
//        }
    }
}


