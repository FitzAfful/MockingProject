//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import UIKit
import TagListView

class DetailController: UIViewController {

	@IBOutlet weak var tagConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var tagListView: TagListView!
	
	var item: Recipe?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setRecipe()
    }

	func setRecipe(){
		guard let recipe = item else { return }
		imageView.setImage(asset: recipe.image)
		titleLabel.text = recipe.title
		
		var description = ""
		if let chef = recipe.chef{
			description = recipe.description + "\n\nChef: " + chef.name
		}else{
			description = recipe.description
		}
		self.descriptionTextView.text = description
		
		if let tags = recipe.tags{
			if(tags.isEmpty){
				self.tagConstraint.constant = 0
				return
			}
			for item in tags{
				tagListView.addTag(item.name)
			}
		}else{
			self.tagConstraint.constant = 0
		}
	}
	
	func initializeFromStoryboard()-> DetailController{
		let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: DetailController.storyboardID) as! DetailController
		return controller
	}
}
