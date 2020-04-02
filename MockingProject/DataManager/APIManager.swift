//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire


public class APIManager: BaseNetworkManager {

    static func getEmployees(completion:@escaping (DataResponse<EmployeesResponse, AFError>)->Void) {
        AF.request(APIRouter.getEmployees).responseDecodable { (response) in
            completion(response)
        }
    }


    static func getSingleEmployee(id: String, completion:@escaping (DataResponse<EmployeeResponse, AFError>)->Void) {
        AF.request(APIRouter.getSingleEmployee(id: id)).responseDecodable { (response) in
            completion(response)
        }
    }
}
