//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation

public class EmployeeDTO: Codable, Equatable {
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

    public static func == (lhs: EmployeeDTO, rhs: EmployeeDTO) -> Bool {
        return (lhs.employeeId == rhs.employeeId)
    }
}

public extension EmployeeDTO {
    func map() -> Employee {
      return Employee(employeeId: self.employeeId, employeeName: self.employeeName, employeeSalary: self.employeeSalary, profileImage: self.profileImage)
    }
}
