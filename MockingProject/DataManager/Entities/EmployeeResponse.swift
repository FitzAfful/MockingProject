//
//  MainResponse.swift
//  Created by Fitzgerald Afful on 18/06/2019.
//  Copyright © 2019 geraldo. All rights reserved.
//

import Foundation
import Alamofire

struct MainResponse : Codable {

        var items : [Item]? = []
        let limit : Int?
        let skip : Int?
        let total : Int

}
