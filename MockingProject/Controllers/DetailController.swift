//
//  DetailController.swift
//  MarleySpoonTest
//
//  Created by Fitzgerald Afful on 20/06/2019.
//  Copyright © 2019 geraldo. All rights reserved.
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
