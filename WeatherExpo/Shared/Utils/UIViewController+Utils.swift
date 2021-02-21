//
//  AppDelegate.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

protocol StoryboardLoadable {
    static func instantiateFromStoryboard() -> Self
}

extension UIViewController: StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    static func instantiateFromStoryboard() -> Self {
        let storyboardID = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: storyboardID)

        if let typedViewController = viewController as? Self {
            return typedViewController
        } else {
            assert(false, "Can't instantiate a viewController for class\(storyboardID)")
            return Self()
        }
    }
}
