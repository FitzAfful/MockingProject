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


    /*This is in line with multiple Environments. You'll notice in the Project Settings, I have 3 targets. Development, Test and Production.
     All 3 targets have their own unique bundle indentifiers and Info.plist files which have been renamed.
     In each of the info.plist file, there's a variable envVar. envVar shows you which environment you are working in at the moment. */
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
