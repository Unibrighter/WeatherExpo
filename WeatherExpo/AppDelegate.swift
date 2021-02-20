//
//  AppDelegate.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Property
    public var window: UIWindow?
    public var mainNavigationController: MainNavigationController?

    // MARK: Conformance - UIApplicationDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configAppearance()
       
        let screenBounds = UIScreen.main.bounds
        window = UIWindow(frame: screenBounds)
        mainNavigationController = MainNavigationController.instantiateFromStoryboard()

        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func configAppearance() {
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().barTintColor = .backgroundDarkBlue
        UINavigationBar.appearance().tintColor = .white
    }
}

