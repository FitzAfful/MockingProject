//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

	@IBOutlet weak var recipeImageView: UIImageView!
	@IBOutlet weak var recipeTitleLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}
	
	var item: Recipe? {
		didSet {
			guard let recipe = item else { return }
			self.recipeTitleLabel.text = recipe.title
			self.recipeImageView.setImage(asset: recipe.image)
		}
	}
    
}
