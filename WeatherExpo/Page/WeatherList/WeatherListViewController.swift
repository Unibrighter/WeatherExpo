//
//  WeatherListViewController.swift
//  WeatherExpo
//
//  Created by Bitmad on 20/2/21.
//

import Foundation
import UIKit

final class WeatherListViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet var alphabetOrderButton: UIButton!
    @IBOutlet var temperatureOrderButton: UIButton!
    @IBOutlet var lastUpdatedOrderButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    private lazy var presenter: WeatherListPresenter = .init(display: self)
    private var items: [WeatherListCellItem] = []
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter.displayDidLoad()
    }
    
    // MARK: Helper Functions
    
    private func setup() {
        navigationItem.title = "Weather List"
        
        tableView.register(WeatherListCell.loadXIB(), forCellReuseIdentifier: WeatherListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

// MARK: Conformance - IBAction
extension WeatherListViewController {
    @IBAction func onAlphabetOrderButtonTapped(_ sender: Any) {
    }
    @IBAction func onTemperatureOrderButtonTapped(_ sender: Any) {
    }
    @IBAction func onLastUpdatedOrderButtonTapped(_ sender: Any) {
    }
}

// MARK: Conformance - UITableViewDelegate, UITableViewDataSource
extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.identifier) as? WeatherListCell else {
            return UITableViewCell()
        }
        cell.config(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].action?()
    }
}

// MARK: Conformance - WeatherListDisplaying
extension WeatherListViewController: WeatherListDisplaying {
    func set(items: [WeatherListCellItem]) {
        self.items = items
        tableView.reloadData()
    }
    func navigate(to item: WeatherListCellItem) {
        let detailViewController = WeatherDetailViewController.instantiateFromStoryboard()
        detailViewController.detailItem = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
