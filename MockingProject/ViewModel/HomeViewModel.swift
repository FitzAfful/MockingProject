//
//  HomeViewModel.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire

protocol HomeViewModelProtocol {
    mutating func fetchEmployees()
    mutating func setError(_ message: String)
    var employees: [Employee] { get  set }
    var errorMessage: String? { get set }
    var error: Bool { get set }
}

struct HomeViewModel: HomeViewModelProtocol {
    var errorMessage: String?
    var error: Bool = false

    var apiManager: APIManager?
    var employees: [Employee] = []

    init(manager: APIManager = APIManager()) {
        self.apiManager = manager
    }

    mutating func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    mutating func fetchEmployees() {
        /*self.apiManager!.getEmployees { (result: DataResponse<EmployeesResponse,AFError>) in
            switch result.result {
            case .success(let response):
                if(response.status == "success"){
                    self.employees = response.data
                    return
                }
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            }
        }*/
    }

    mutating func setError(_ message: String) {
        self.errorMessage = message
        self.error = true
    }

}
