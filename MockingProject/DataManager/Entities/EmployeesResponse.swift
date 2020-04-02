//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

struct EmployeesResponse : Codable {

    var data : [Employee]
    let status : String

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
    }
}
