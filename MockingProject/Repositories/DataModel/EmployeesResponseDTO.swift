//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

public struct EmployeesResponseDTO: Codable, Equatable {

    var data: [EmployeeDTO]
    let status: String

    public static func == (lhs: EmployeesResponseDTO, rhs: EmployeesResponseDTO) -> Bool {
        return (lhs.data == rhs.data)
    }
}

public extension EmployeesResponseDTO {
    func map() -> EmployeesResponse {
        var array: [Employee] = []
        for item in self.data {
            array.append(item.map())
        }
        return EmployeesResponse(data: array, status: self.status)
    }
}
