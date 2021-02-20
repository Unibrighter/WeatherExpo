//
//  UIColor+Utils.swift
//  QuokkaParking
//
//  Created by Bitmad on 19/11/20.
//

import Foundation
import UIKit

extension UIColor {
    static var accentLightBlue: UIColor {
        return UIColor(red: 167/255.0, green: 231/255.0, blue: 234/255.0, alpha: 1.0)
    }
    
    static var backgroundDarkBlue: UIColor {
        return UIColor(red: 39/255.0, green: 70/255.0, blue: 87/255.0, alpha: 1.0)
    }
    
    func colorImage() -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
