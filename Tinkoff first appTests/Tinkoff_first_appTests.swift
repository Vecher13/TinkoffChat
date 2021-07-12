//
//  Tinkoff_first_appTests.swift
//  Tinkoff first appTests
//
//  Created by Ash on 06.05.2021.
//

import XCTest
@testable import Tinkoff_first_app

class TinkoffFirstAppTests: XCTestCase {
    
    var sut: URLSession!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
          try super.tearDownWithError()
        
    }
    
    func testApiCallCompletes() throws {
      // given
       let urlFromController = PhotoPickerViewController().url
        guard let url = urlFromController else { return }
      let feedBack = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
        
      let dataTask = sut.dataTask(with: url) { _, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        feedBack.fulfill()
      }
      dataTask.resume()
      wait(for: [feedBack], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
