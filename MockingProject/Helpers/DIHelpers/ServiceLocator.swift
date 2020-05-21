//
//  DIServiceLocator.swift
//  Development
//
//  Created by Fitzgerald Afful on 21/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

protocol ServiceLocator {
    func resolve<T>() -> T?
}

final class DIServiceLocator: ServiceLocator {

    static let shared = DIServiceLocator()

    private lazy var services: Dictionary<String, Any> = [:]
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ?
            "\(some)" : "\(type(of: some))"
    }

    func register<T>(_ service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
