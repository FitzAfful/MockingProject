//
//  DepInjectionViewModel.swift
//  Development
//
//  Created by Fitzgerald Afful on 20/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire

class ResolverViewModel: HomeViewModelProtocol {

    var apiManager: APIManager!
    var employees: [Employee] = []

    init(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchEmployees(completion: @escaping ([Employee]?, String?) -> Void) {
        apiManager!.getEmployees { (result: DataResponse<EmployeesResponse, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees = response.data
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
