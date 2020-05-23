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

    static let sharedContainer = SwinjectContainer()
    let container = Container()

    private init() {
        setupDefaultContainers()
    }

    private func setupDefaultContainers() {
        container.register(EmployeeRepository.self, factory: { _ in APIEmployeeRepository() })

        container.register(HomeViewModelProtocol.self, factory: { resolver in
            return SwinjectViewModel(repository: resolver.resolve(EmployeeRepository.self)!)
        })
    }
}
