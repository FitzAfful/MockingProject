//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import UIKit

class DetailController: UIViewController, MyEnvironmentHelper {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!

	var item: Employee?
    override func viewDidLoad() {
        super.viewDidLoad()
		setEmployee()
    }

	func setEmployee() {
		guard let employee = item else { return }
        imageView.setImage(url: employee.profileImage)
        self.title = "Environment - \(getEnvValue()!)"
		titleLabel.text = employee.employeeName
        let description = "Salary: " + employee.employeeSalary
		self.descriptionTextView.text = description

	}

	func initializeFromStoryboard() -> DetailController {
		let controller = AppStoryboard.main.instance.instantiateViewController(withIdentifier: DetailController.storyboardID) as! DetailController
		return controller
	}
}
