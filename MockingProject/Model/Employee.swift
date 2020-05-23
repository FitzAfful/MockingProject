//
//  EmployeeDTO.swift
//  Development
//
//  Created by Fitzgerald Afful on 23/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

public struct Employee {
    var employeeId: String
    var employeeName: String
    var employeeSalary: String
    var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case employeeId = "id"
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case profileImage = "profile_image"
    }
}
