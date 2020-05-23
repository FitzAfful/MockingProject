//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

public struct EmployeeResponseDTO: Codable, Equatable {

    var data: EmployeeDTO
    let status: String
}

public extension EmployeeResponseDTO {
    func map() -> EmployeeResponse {
        return EmployeeResponse(data: self.data.map(), status: self.status)
    }
}
