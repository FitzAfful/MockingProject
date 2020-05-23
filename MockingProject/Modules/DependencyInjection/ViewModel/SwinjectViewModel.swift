//
//  HomeViewModel.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire

class SwinjectViewModel: HomeViewModelProtocol {

    var employeeRepository: EmployeeRepository?
    var employees: [Employee] = []

    init(repository: EmployeeRepository = APIEmployeeRepository()) {
        self.employeeRepository = repository
    }

    func fetchEmployees(completion: @escaping ([Employee]?, String?) -> Void) {
        self.employeeRepository!.getEmployees { (result: DataResponse<EmployeesResponseDTO, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees =  response.map().data
                    completion(self.employees, nil)
                    return
                }
                completion(nil, BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
                completion(nil, BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

}
