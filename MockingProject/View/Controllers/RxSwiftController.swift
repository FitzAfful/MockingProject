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
import RxSwift
import RxCocoa

class RxSwiftController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let disposeBag = DisposeBag()

    lazy var viewModel: RxSwiftViewModel = {
        let viewModel = RxSwiftViewModel()
        return viewModel
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
		showLoader()
		setupTableView()
        setupBindings()
	}

    func setupBindings() {
        viewModel.employees.drive(onNext: {[unowned self] (_) in
            self.showTableView()
        }).disposed(by: disposeBag)

        viewModel.errorMessage.drive(onNext: { (_message) in
            if let message = _message {
                self.showAlert(title: "Error", message: message)
            }
        }).disposed(by: disposeBag)
    }

	func setupTableView() {
		self.tableView.register(UINib(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.tableFooterView = UIView()

		self.tableView.es.addPullToRefresh {
            self.viewModel.fetchEmployees()
		}
		self.tableView.es.startPullToRefresh()
	}

    func showErrorMessage(_ message: String) {
        self.showTableView()
        self.showAlert(title: "Error", message: message)
    }

	func showLoader() {
		self.tableView.isHidden = true
		self.emptyView.isHidden = true
		self.activityIndicator.isHidden = false
		self.activityIndicator.startAnimating()
	}

	func showTableView() {
        DispatchQueue.main.async {
            self.tableView.es.stopPullToRefresh()
            if self.viewModel.numberOfEmployees == 0 {
                self.showEmptyView()
            } else {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.emptyView.isHidden = true
                self.activityIndicator.isHidden = true
            }
        }
    }

    func showEmptyView() {
        self.tableView.isHidden = true
        self.emptyView.isHidden = false
        self.activityIndicator.isHidden = true
    }

	func moveToDetails(item: Employee) {
		DispatchQueue.main.async {
			let detailController = DetailController().initializeFromStoryboard()
			detailController.item = item
			self.navigationController?.pushViewController(detailController, animated: true)
		}
	}

}

extension RxSwiftController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel.modelForIndex(at: indexPath.row) {
            self.moveToDetails(item: item)
        }
	}
}

extension RxSwiftController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfEmployees
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        if let item = viewModel.modelForIndex(at: indexPath.row) {
            cell.item = item
        }
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
	}
}
