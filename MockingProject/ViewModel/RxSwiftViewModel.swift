//
//  HomeViewModel.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa


class RxSwiftViewModel {

    private let disposeBag = DisposeBag()
    private let _employees = BehaviorRelay<[Employee]>(value: [])
    private let _error = BehaviorRelay<Bool>(value: false)
    private let _errorMessage = BehaviorRelay<String?>(value: nil)

    var employees: Driver<[Employee]> {
       return _employees.asDriver()
    }

    var hasError: Bool {
       return _error.value
    }

    var errorMessage: Driver<String?> {
       return _errorMessage.asDriver()
    }

    var numberOfEmployees: Int {
       return _employees.value.count
    }

    var apiManager: APIManager?

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
                    self._error.accept(false)
                    self._errorMessage.accept(nil)
                    self._employees.accept(response.data)
                    return
                }
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

    func setError(_ message: String) {
        self._error.accept(true)
        self._errorMessage.accept(message)
    }

    func modelForIndex(at index: Int) -> Employee? {
        guard index < _employees.value.count else {
            return nil
        }
        return _employees.value[index]
    }
}
