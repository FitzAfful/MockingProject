//
//  GenericDataSource.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation


typealias CompletionHandler = (() -> Void)

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class DynamicValue<T> {

    var value : T {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ $0.value() })
    }

    deinit {
        observers.removeAll()
    }
}
