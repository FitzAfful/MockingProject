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

class HomeController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	var manager: APIManager!
	var recipes: [Recipe] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		showLoader()
		setupTableView()
	}
	
	func setupTableView(){
		manager = APIManager()
		self.tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.tableFooterView = UIView()
		self.tableView.es.addPullToRefresh {
			self.getRecipes()
		}
		self.tableView.es.startPullToRefresh()
	}
	
	func getRecipes(){
		manager.getRecipes { (recipes, error) in
			if let error = error {
				self.showAlert(title: "Error", message: error.localizedDescription)
				return
			}
			if let recipes = recipes {
				self.recipes = recipes
				self.showTableView()
			}
		}
	}

	func showLoader(){
		self.tableView.isHidden = true
		self.emptyView.isHidden = true
		self.activityIndicator.isHidden = false
		self.activityIndicator.startAnimating()
	}
	
	func showEmptyView(){
		self.tableView.isHidden = true
		self.emptyView.isHidden = false
		self.activityIndicator.isHidden = true
	}
	
	func showTableView(){
		DispatchQueue.main.async {
			self.tableView.es.stopPullToRefresh()
			self.tableView.reloadData()
			self.tableView.isHidden = false
			self.emptyView.isHidden = true
			self.activityIndicator.isHidden = true
		}
	}
	
	func moveToDetails(item: Recipe){
		DispatchQueue.main.async {
			let detailController = DetailController().initializeFromStoryboard()
			detailController.item = item
			self.navigationController?.pushViewController(detailController, animated: true)
		}
	}

}

extension HomeController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = self.recipes[indexPath.row]
		self.moveToDetails(item: item)
	}
}


extension HomeController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
		cell.item = self.recipes[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 230.0
	}
}
