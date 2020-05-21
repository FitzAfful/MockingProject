//
//  SwinjectStoryboardContainer.swift
//  Development
//
//  Created by Fitzgerald Afful on 21/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    @objc class func setup() {
        let mainContainer = SwinjectContainer.sharedContainer.container

        defaultContainer.storyboardInitCompleted(SwinjectController.self) { _, controller in
            controller.viewModel = mainContainer.resolve(HomeViewModelProtocol.self)
        }
    }
}
