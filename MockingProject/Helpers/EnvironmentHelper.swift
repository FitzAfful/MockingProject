//
//  EnvironmentHelper.swift
//  Development
//
//  Created by Fitzgerald Afful on 09/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

class EnvironmentHelper {
    static var shared: EnvironmentHelper = {
        return EnvironmentHelper()

    }()

    func getEnvValue() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "envVar") as? String
    }
}

//This can be created in another form. As Below

protocol MyEnvironmentHelper {}

extension MyEnvironmentHelper {
    func getEnvValue() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "envVar") as? String
    }
}

//The Above example is used in DetailController
