//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {

	@IBOutlet weak var employeeImageView: UIImageView!
	@IBOutlet weak var employeeTitleLabel: UILabel!
    @IBOutlet weak var employeeSalaryLabel: UILabel!

	var item: Employee? {
		didSet {
			guard let employee = item else { return }
            self.employeeTitleLabel.text = employee.employeeName
            self.employeeSalaryLabel.text = employee.employeeSalary
            self.employeeImageView.setImage(url: employee.profileImage)
		}
	}
}
