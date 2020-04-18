//
//  EventBus.swift
//  Development
//
//  Created by Fitzgerald Afful on 18/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

open class EventBus {

    struct Static {
        static let instance = EventBus()
        static let queue = DispatchQueue(label: "EventBus", attributes: [])
    }

    struct NamedObserver {
        let observer: NSObjectProtocol
        let name: String
    }

    var cache = [UInt: [NamedObserver]]()

    ////////////////////////////////////
    // Publish
    ////////////////////////////////////

    open class func post(_ name: String) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil)
    }

    open class func post(_ name: String, sender: AnyObject?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
    }

    open class func post(_ name: String, sender: NSObject?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
    }

    open class func post(_ name: String, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil, userInfo: userInfo)
    }

    open class func post(_ name: String, sender: AnyObject?, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender, userInfo: userInfo)
    }

    open class func postToMainThread(_ name: String) {
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil)
        })
    }

    open class func postToMainThread(_ name: String, sender: AnyObject?) {
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
        })
    }

    open class func postToMainThread(_ name: String, sender: NSObject?) {
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
        })
    }

    open class func postToMainThread(_ name: String, userInfo: [AnyHashable: Any]?) {
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil, userInfo: userInfo)
        })
    }

    open class func postToMainThread(_ name: String, sender: AnyObject?, userInfo: [AnyHashable: Any]?) {
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender, userInfo: userInfo)
        })
    }

    ////////////////////////////////////
    // Subscribe
    ////////////////////////////////////

    open class func on(_ target: AnyObject, name: String, sender: AnyObject?, queue: OperationQueue?, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: sender, queue: queue, using: handler)
        let namedObserver = NamedObserver(observer: observer, name: name)

        Static.queue.sync {
            if let namedObservers = Static.instance.cache[id] {
                Static.instance.cache[id] = namedObservers + [namedObserver]
            } else {
                Static.instance.cache[id] = [namedObserver]
            }
        }

        return observer
    }

    open class func onMainThread(_ target: AnyObject, name: String, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        return EventBus.on(target, name: name, sender: nil, queue: OperationQueue.main, handler: handler)
    }

    open class func onMainThread(_ target: AnyObject, name: String, sender: AnyObject?, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        return EventBus.on(target, name: name, sender: sender, queue: OperationQueue.main, handler: handler)
    }

    open class func onBackgroundThread(_ target: AnyObject, name: String, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        return EventBus.on(target, name: name, sender: nil, queue: OperationQueue(), handler: handler)
    }

    open class func onBackgroundThread(_ target: AnyObject, name: String, sender: AnyObject?, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        return EventBus.on(target, name: name, sender: sender, queue: OperationQueue(), handler: handler)
    }

    ////////////////////////////////////
    // Unregister
    ////////////////////////////////////

    open class func unregister(_ target: AnyObject) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default

        Static.queue.sync {
            if let namedObservers = Static.instance.cache.removeValue(forKey: id) {
                for namedObserver in namedObservers {
                    center.removeObserver(namedObserver.observer)
                }
            }
        }
    }

    open class func unregister(_ target: AnyObject, name: String) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default

        Static.queue.sync {
            if let namedObservers = Static.instance.cache[id] {
                Static.instance.cache[id] = namedObservers.filter({ (namedObserver: NamedObserver) -> Bool in
                    if namedObserver.name == name {
                        center.removeObserver(namedObserver.observer)
                        return false
                    } else {
                        return true
                    }
                })
            }
        }
    }

}