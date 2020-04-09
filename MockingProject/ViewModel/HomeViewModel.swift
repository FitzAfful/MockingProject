//
//  HomeViewModel.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchEmployees()
    func setError()
}

struct HomeViewModel : HomeViewModelProtocol {

    var apiManager: APIManager?
    var employees: [Employee] = []

    init(manager : APIManager = APIManager()) {
        self.apiManager = manager
    }

    mutating func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchEmployees() {
        self.apiManager!.getEmployees { (result: DataResponse<EmployeesResponse,AFError>) in
            switch result.result {
            case .success(let response):
                if(response.status == "success"){
                    self.employees = response.data
                    self.showTableView()
                    return
                }
                self.showAlert(title: "Error", message: BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
                self.showAlert(title: "Error", message: BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

    

}
