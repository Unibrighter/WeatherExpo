//
//  WeatherFilterViewController.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

final class WeatherFilterViewController: UIViewController {
        
    // MARK: Property
    
    @IBOutlet var tableView: UITableView!
    
    var items: [Country] = []
    var filterSetAction: ((FilterOption) -> Void)?
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Helper Functions
    
    private func setup() {
        navigationItem.title = "Weather List"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(onCancelButtonTapped))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    @objc private func onCancelButtonTapped() {
        filterSetAction?(.noFilter)
        dismiss(animated: true)
    }
}

// MARK: Conformance - UITableViewDelegate, UITableViewDataSource

extension WeatherFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = items[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .accentLightBlue
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        filterSetAction?(.country(items[indexPath.row]))
        self.dismiss(animated: true)
    }
}
