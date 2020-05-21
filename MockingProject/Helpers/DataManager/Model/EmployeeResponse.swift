//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

struct EmployeeResponse: Codable, Equatable {

    var data: Employee
    let status: String

    static public func == (lhs: EmployeeResponse, rhs: EmployeeResponse) -> Bool {
        return (lhs.data.employeeId == rhs.data.employeeId)
    }
}
