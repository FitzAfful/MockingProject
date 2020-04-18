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

class EventBusController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    lazy var viewModel: EventBusViewModel = {
        let viewModel = EventBusViewModel()
        return viewModel
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
		showLoader()
        setupEventBus()
		setupTableView()
	}

    func setupEventBus() {
        _ = EventBus.onMainThread(self, name: "fetchEmployees") { result in
            if let event = result!.object as? EmployeesEvent {
                if event.employees != nil {
                    self.showTableView()
                } else if let message = event.errorMessage {
                    self.showAlert(title: "Error", message: message)
                }
            }
        }
    }

	func setupTableView() {
		self.tableView.register(UINib(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.tableFooterView = UIView()
		self.tableView.es.addPullToRefresh {
			self.getEmployees()
		}
		self.tableView.es.startPullToRefresh()
	}

	func getEmployees() {
        viewModel.fetchEmployees()
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
            if self.viewModel.employees.isEmpty {
                self.showEmptyView()
            } else {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.emptyView.isHidden = true
                self.activityIndicator.isHidden = true
            }
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

extension EventBusController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.employees[indexPath.row]
		self.moveToDetails(item: item)
	}
}

extension EventBusController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.employees.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
		cell.item = self.self.viewModel.employees[indexPath.row]
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
	}
}
