//
//  SwinjectHelper.swift
//  Development
//
//  Created by Fitzgerald Afful on 21/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Swinject

class SwinjectContainer {

    // 1
    static let sharedContainer = SwinjectContainer()

    // 2
    let container = Container()

    private init() {
        setupDefaultContainers()
    }

    // 3
    private func setupDefaultContainers() {

        container.register(APIManager.self, factory: { _ in APIManager() })
    }
}
