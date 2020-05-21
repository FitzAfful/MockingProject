//
//  AppDelegate.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 02/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MSAppCenter.start("ede02f1f-31af-4da6-8c8f-395519dda28a", withServices: [
          MSAnalytics.self,
          MSCrashes.self
        ])
        _ = SwinjectContainer.sharedContainer

        //ServiceLocator Registrations
        let serviceLocator = DIServiceLocator.shared
        serviceLocator.register(APIManager() as APIManager)

        guard let manager: APIManager = serviceLocator.resolve() else { return true }
        serviceLocator.register(HomeViewModel(manager: manager))

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
