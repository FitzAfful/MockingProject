//
//  Entities.swift
//  MarleySpoonTest
//
//  Created by Fitzgerald Afful on 18/06/2019.
//  Copyright © 2019 geraldo. All rights reserved.
//

import Foundation

public class Employee : Codable {
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
}
