//
//  MainResponse.swift
//  Created by Fitzgerald Afful on 18/06/2019.
//  Copyright © 2019 geraldo. All rights reserved.
//

import Foundation
import Alamofire

struct EmployeeResponse : Codable {
    var data : Employee
    let status : String

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
    }
}
