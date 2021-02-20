//
//  CellDisplaying.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

protocol Reusable {
    static var identifier: String { get }
}

protocol XIBLoadable {
    static func loadXIB() -> UINib
}

extension Reusable {
    static var identifier: String {
        let className = String(describing: self)
        return className
    }
}

extension XIBLoadable {
    static func loadXIB() -> UINib {
        let className = String(describing: self)
        let xib = UINib(nibName: className, bundle: nil)
        return xib
    }
}

typealias ReusableXIBLoadable = Reusable & XIBLoadable

protocol CellDisplayable: Reusable, XIBLoadable {
    var action: (() -> Void)? { get set }
    func extractCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}
