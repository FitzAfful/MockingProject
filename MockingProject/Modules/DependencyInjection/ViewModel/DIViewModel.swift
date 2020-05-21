//
//  DepInjectionViewModel.swift
//  Development
//
//  Created by Fitzgerald Afful on 20/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire
import Resolver

class DIViewModel: HomeViewModelProtocol, Resolving {

    var employees: [Employee] = []

    func fetchEmployees(completion: @escaping ([Employee]?, String?) -> Void) {
        guard let apiManager: APIManager = Resolver.resolve() else { return }
        apiManager.getEmployees { (result: DataResponse<EmployeesResponse, AFError>) in
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
