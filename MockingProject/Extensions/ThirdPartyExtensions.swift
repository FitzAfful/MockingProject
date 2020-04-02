//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import UIKit
import Nuke

//Nuke Extension
extension UIImageView {
	func setImage(url: String?){
		guard let myURL = url, !myURL.isEmpty else {
			return
		}
		let mainURL = URL(string: myURL)!
		Nuke.loadImage(with: mainURL, into: self)
	}
	
}

