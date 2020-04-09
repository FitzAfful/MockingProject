//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation

public class Employee : Codable, Equatable {
	public var id: String
	var employeeName: String
	var employeeSalary: String
    var profileImage: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case profileImage = "profile_image"
    }

    public static func == (lhs: Employee, rhs: Employee) -> Bool {
        return (lhs.id == rhs.id)
    }
}
