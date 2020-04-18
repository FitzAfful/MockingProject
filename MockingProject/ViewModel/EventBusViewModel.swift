//
//  HomeViewModel.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire

protocol EventBusModelProtocol {
    func fetchEmployees()
    var employees: [Employee] { get  set }
    func setError(_ message: String)
    var errorMessage: String? { get set }
    var error: Bool { get set }
}

class EventBusViewModel: EventBusModelProtocol {
    var errorMessage: String?
    var error: Bool = false
    var apiManager: APIManager?
    var employees: [Employee] = []

    init(manager: APIManager = APIManager()) {
        self.apiManager = manager
    }

    func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchEmployees() {
        self.apiManager!.getEmployees { (result: DataResponse<EmployeesResponse, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees = response.data
                    return
                }
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
            self.setError(BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

    func setError(_ message: String) {
        self.errorMessage = message
        self.error = true
    }

    func callEvent() {
        EventBus.post("fetchEmployees", sender: EmployeesEvent(error: error, errorMessage: errorMessage, employees: employees))
    }

}
