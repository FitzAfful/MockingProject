//
//  EmployeeTests.swift
//  MockingProjectTests
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import XCTest
@testable import Development
@testable import Alamofire
@testable import Mocker

class EmployeeTests: XCTestCase {

    var bundle: Bundle!

    override func setUp() {
        bundle = Bundle(for: EmployeeTests.self)
    }

    func testSingleEmployeeResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "employee24", withExtension: "json") else {
            XCTFail("Missing file: Employee24.json")
            return
        }

        let json = try Data(contentsOf: url)
        let employee = try! JSONDecoder().decode(EmployeeResponse.self, from: json)

        XCTAssertEqual(employee.data.employeeName, "Doris Wilder")
        XCTAssertEqual(employee.data.employeeSalary, "85600")
    }

    func testEmployeesResponseJSONMapping() throws {
        guard let url = bundle.url(forResource: "employees", withExtension: "json") else {
            XCTFail("Missing file: Employees.json")
            return
        }

        let json = try Data(contentsOf: url)
        let data = try! JSONDecoder().decode(EmployeesResponse.self, from: json)

        XCTAssertEqual(data.data[0].employeeName, "Tiger Nixon")
        XCTAssertEqual(data.data[0].employeeSalary, "320800")
    }
}
