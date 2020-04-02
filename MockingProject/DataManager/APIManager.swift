//
//  APIManager.swift
//  MarleySpoonTest
//
//  Created by Fitzgerald Afful on 19/06/2019.
//  Copyright © 2019 geraldo. All rights reserved.
//

import Foundation
import Alamofire

/*typealias RecipesCompletionHandler = (_ result: Result<ArrayResponse<Entry>>) -> Void
typealias RecipeCompletionHandler = (_ result: Result<Recipe>) -> Void*/
typealias RecipesCompletionHandler = (_ recipes: [Recipe]?, _ error: Error?) -> Void

public class APIManager: BaseNetworkManager {
	
	/*private let client = Client(spaceId: "kk2bw5ojx476", accessToken: "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c", contentTypeClasses: [Recipe.self])
	
	func fetchRecipes(completionHandler: @escaping RecipesCompletionHandler){
	client.fetchArray(of: Entry.self){ (result: Result<ArrayResponse<Entry>>) in
	completionHandler(result)
	}
	}
	
	func fetchSingleRecipe(id: String, completionHandler: @escaping RecipeCompletionHandler){
	client.fetch(Recipe.self, id: id) { (result: Result<Recipe>) in
	completionHandler(result)
	}
	}*/
	
	func getRecipes(completion:@escaping (_ recipes: [Recipe]?, _ error: Error?) -> Void) {
		AF.request(APIRouter.getRecipes).responseDecodable { (response: DataResponse<MainResponse>) in
			switch response.result {
			case .failure:
				completion(nil, response.error)
			case .success(let mainResponse):
				var recipes: [Recipe] = []
				guard let mainRecipeItems = mainResponse.items else {
					completion(nil, response.error)
					return
				}
				let items = mainRecipeItems.map { return $0 }
				for item in items {
					let recipe = Recipe()
					recipe.title = item.fields!.title ?? ""
					recipe.description = item.fields!.description ?? ""
					
					if let chef = item.fields?.chef {
						let index = mainResponse.includes?.entry!.firstIndex(where: { $0.sys!.id == chef.sys!.id})
						recipe.chef = Chef(id: chef.sys!.id!, name: mainResponse.includes!.entry![index!].fields!.name)
						
					}
					
					if let recipeTags = item.fields?.tags {
						var tags:[Tag] = []
						for tag in recipeTags {
							let index = mainResponse.includes?.entry?.firstIndex(where: { $0.sys!.id == tag.sys!.id})
							tags.append(Tag(id: tag.sys!.id!, name: mainResponse.includes!.entry![index!].fields!.name))
						}
						recipe.tags = tags
					}
					
					if let photo = item.fields?.photo {
						let index = mainResponse.includes?.asset!.firstIndex(where: { $0.sys.id == photo.sys!.id})
						recipe.image =  mainResponse.includes!.asset![index!]
						
					}
					
					recipes.append(recipe)
				}
				completion(recipes, nil)
			}
			
		}
	}
	
}
