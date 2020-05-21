//
//  SwiftBusEmployee.swift
//  Development
//
//  Created by Fitzgerald Afful on 18/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

class EmployeesEvent: NSObject {
    var error: Bool
    var errorMessage: String?
    var employees: [Employee]?

    init(error: Bool, errorMessage: String? = nil, employees: [Employee]? = nil) {
        self.error = error
        self.errorMessage = errorMessage
        self.employees = employees
    }
}
