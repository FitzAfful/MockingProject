//
//  AppDelegate+Injection.swift
//  Development
//
//  Created by Fitzgerald Afful on 12/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerAPIManager()
    }
}
