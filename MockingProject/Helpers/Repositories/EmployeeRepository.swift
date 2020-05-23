//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

protocol EmployeeRepository {
    func getEmployees(completion:@escaping (DataResponse<EmployeesResponse, AFError>) -> Void)
    func getSingleEmployee(employeeId: String, completion:@escaping (DataResponse<EmployeeResponse, AFError>) -> Void)
}

public class APIEmployee {

    private let manager: Session

    init(manager: Session = Session.default) {
        self.manager = manager
    }

    func getEmployees(completion:@escaping (DataResponse<EmployeesResponse, AFError>) -> Void) {
        manager.request(APIRouter.getEmployees).responseDecodable { (response) in
            completion(response)
        }
    }

    func getSingleEmployee(employeeId: String, completion:@escaping (DataResponse<EmployeeResponse, AFError>) -> Void) {
        manager.request(APIRouter.getSingleEmployee(employeeId: employeeId)).responseDecodable { (response) in
            completion(response)
        }
    }
}
