//
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
    var employeeRepository: EmployeeRepository?
    var employees: [Employee] = []

    init(repository: EmployeeRepository = APIEmployeeRepository()) {
        self.employeeRepository = repository
    }

    func setEmployeeRepository(repository: EmployeeRepository) {
        self.employeeRepository = repository
    }

    func fetchEmployees() {
        self.employeeRepository!.getEmployees { (result: DataResponse<EmployeesResponseDTO, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees = response.map().data
                } else {
                    self.setError(BaseNetworkManager().getErrorMessage(response: result))
                }
                self.callEvent()
            case .failure:
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
                self.callEvent()
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
