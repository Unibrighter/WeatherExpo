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

    @IBOutlet var separaterContainerView: UIView!
    @IBOutlet var alphabetOrderHighlightIndicatorView: UIView!
    @IBOutlet var temperatureOrderHighlightIndicatorView: UIView!
    @IBOutlet var lastUpdatedOrderrHighlightIndicatorView: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    private lazy var orderOptionButtons: [UIButton] = [
        alphabetOrderButton,
        temperatureOrderButton,
        lastUpdatedOrderButton
    ]
    
    private lazy var presenter: WeatherListPresenter = .init(display: self)
    private var items: [WeatherListCellItem] = []
    private var filterButtonAction: (() -> Void)?
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter.displayDidLoad()
    }
}

// MARK: Conformance - IBAction

extension WeatherListViewController {
    @IBAction func onAlphabetOrderButtonTapped(_ sender: Any) {
        apply(orderOption: .alphabet)
    }
    @IBAction func onTemperatureOrderButtonTapped(_ sender: Any) {
        apply(orderOption: .temperature)
    }
    @IBAction func onLastUpdatedOrderButtonTapped(_ sender: Any) {
        apply(orderOption: .lastUpdated)
    }
    @IBAction func onFilterButtonTapped(_ sender: Any) {
        filterButtonAction?()
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
    
    func resetFilter() {
        presenter.filter = .noFilter
    }
    
    func set(filterCountries: [FilterCountryItem]) {
        filterButtonAction = { [weak self] in
            let filterViewController = WeatherFilterViewController.instantiateFromStoryboard()
            filterViewController.items = filterCountries
            filterViewController.filterResetAction = {
                self?.resetFilter()
            }
            self?.present(UINavigationController(rootViewController: filterViewController), animated: true)
        }
    }
    
    func set(items: [WeatherListCellItem]) {
        self.items = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func navigate(to item: WeatherListCellItem) {
        let detailViewController = WeatherDetailViewController.instantiateFromStoryboard()
        detailViewController.detailItem = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func show(currentIndicator filterOption: FilterOption) {
        switch filterOption {
        case .country(let country):
            filterButton.setTitle("Filtered: \(country.name)", for: .normal)
        default:
            filterButton.setTitle("Set Filter", for: .normal)
        }
    }
}

// MARK: Helper Functions

private extension WeatherListViewController {
    func apply(orderOption: OrderOption, forceRefresh: Bool = false) {
        guard forceRefresh || presenter.order != orderOption else {
            return
        }
        highlight(orderOption: orderOption)
        presenter.order = orderOption
    }
    
    func setup() {
        navigationItem.title = "Weather List"
        configAppearnce()
        
        tableView.register(WeatherListCell.loadXIB(), forCellReuseIdentifier: WeatherListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWeatherList), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshWeatherList() {
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        presenter.refreshWeatherList { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func configAppearnce() {
        filterButton.setTitleColor(.gray, for: .normal)
        
        orderOptionButtons.forEach { $0.setTitleColor(.gray, for: .normal) }
        
        highlight(orderOption: .alphabet)
    }
    
    func highlight(orderOption: OrderOption) {
        let attributedString = NSMutableAttributedString(string: orderOption.buttonText,
                                                         attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        orderOptionButtons.forEach {
            let attributedString = NSAttributedString(string: $0.titleLabel?.text ?? "")
            $0.setAttributedTitle(attributedString, for: .normal)
        }
        
        alphabetOrderHighlightIndicatorView.isHidden = true
        temperatureOrderHighlightIndicatorView.isHidden = true
        lastUpdatedOrderrHighlightIndicatorView.isHidden = true
        
        switch orderOption {
        case .alphabet:
            alphabetOrderButton.setAttributedTitle(attributedString, for: .normal)
            alphabetOrderHighlightIndicatorView.isHidden = false
        case .temperature:
            temperatureOrderButton.setAttributedTitle(attributedString, for: .normal)
            temperatureOrderHighlightIndicatorView.isHidden = false
        case .lastUpdated:
            lastUpdatedOrderButton.setAttributedTitle(attributedString, for: .normal)
            lastUpdatedOrderrHighlightIndicatorView.isHidden = false
        }
    }
}
