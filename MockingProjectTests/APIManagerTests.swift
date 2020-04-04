//
//  MockingProjectTests.swift
//  MockingProjectTests
//
//  Created by Fitzgerald Afful on 02/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import XCTest
@testable import MockingProject
@testable import Alamofire

class MockingProjectTests: XCTestCase {

    private var manager: APIManager!

    override func setUp() {
        let sessionManager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockURLProtocol.self]
                return configuration
            }()

            return Session(configuration: configuration)
        }()
        manager = APIManager(manager: sessionManager)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
