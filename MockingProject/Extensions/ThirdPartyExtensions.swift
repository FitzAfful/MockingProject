//
//  ThirdPartyExtensions.swift
//  MarleySpoonTest
//
//  Created by Paa Quesi Afful on 15/06/2019.
//  Copyright © 2019 geraldo. All rights reserved.
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

