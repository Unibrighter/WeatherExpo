//
//  WeatherFilterViewController.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

final class WeatherFilterViewController: UIViewController {
        
    @IBOutlet var tableView: UITableView!
    
    var items: [FilterCountryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Helper Functions
    
    private func setup() {
        navigationItem.title = "Weather List"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onBackButtonTapped))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    @objc private func onBackButtonTapped() {
        self.dismiss(animated: true)
    }
}

// MARK: Conformance - UITableViewDelegate, UITableViewDataSource

extension WeatherFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = items[indexPath.row].country.name
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .accentLightBlue
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
    }
}
