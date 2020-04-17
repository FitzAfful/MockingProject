//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import UIKit
import ESPullToRefresh
import Alamofire

class ObservableController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    lazy var viewModel: ObservableViewModel = {
        let viewModel = ObservableViewModel()
        return viewModel
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
		showLoader()
		setupTableView()
	}

	func setupTableView() {
		self.tableView.register(UINib(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.tableFooterView = UIView()
        viewModel.employees.bind { (employees) in
            self.tableView.reloadData()
        }
		self.tableView.es.addPullToRefresh {
            self.viewModel.fetchEmployees()
		}
		self.tableView.es.startPullToRefresh()
	}

    func showErrorMessage(_ message: String){
        self.showTableView()
        self.showAlert(title: "Error", message: message)
    }

	func showLoader() {
		self.tableView.isHidden = true
		self.emptyView.isHidden = true
		self.activityIndicator.isHidden = false
		self.activityIndicator.startAnimating()
	}

	func showEmptyView() {
		self.tableView.isHidden = true
		self.emptyView.isHidden = false
		self.activityIndicator.isHidden = true
	}

	func showTableView() {
		DispatchQueue.main.async {
			self.tableView.es.stopPullToRefresh()
			self.tableView.reloadData()
			self.tableView.isHidden = false
			self.emptyView.isHidden = true
			self.activityIndicator.isHidden = true
		}
	}

	func moveToDetails(item: Employee) {
		DispatchQueue.main.async {
			let detailController = DetailController().initializeFromStoryboard()
			detailController.item = item
			self.navigationController?.pushViewController(detailController, animated: true)
		}
	}

}

extension ObservableController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.employees.value[indexPath.row]
		self.moveToDetails(item: item)
	}
}

extension ObservableController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.employees.value.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        cell.item = self.viewModel.employees.value[indexPath.row]
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
	}
}
