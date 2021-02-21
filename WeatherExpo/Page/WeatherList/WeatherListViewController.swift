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
    
    // MARK: - IBOutlet
    
    @IBOutlet var alphabetOrderButton: UIButton!
    @IBOutlet var temperatureOrderButton: UIButton!
    @IBOutlet var lastUpdatedOrderButton: UIButton!

    @IBOutlet var separaterContainerView: UIView!
    @IBOutlet var alphabetOrderHighlightIndicatorView: UIView!
    @IBOutlet var temperatureOrderHighlightIndicatorView: UIView!
    @IBOutlet var lastUpdatedOrderrHighlightIndicatorView: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    private lazy var orderOptionButtonsAndIndicators: [(button: UIButton, indicator: UIView)] = [
        (alphabetOrderButton, alphabetOrderHighlightIndicatorView),
        (temperatureOrderButton, temperatureOrderHighlightIndicatorView),
        (lastUpdatedOrderButton, lastUpdatedOrderrHighlightIndicatorView),
    ]
    
    // MARK: - ViewModel Related
    
    private lazy var presenter: WeatherListPresenter = .init(display: self)
    private var items: [WeatherListCellItem] = []
    private var filterButtonAction: (() -> Void)?
    
    private var lastUpdatedDate: Date?
    private var lastUpdatedInfo: String {
        guard let date = lastUpdatedDate else {
            return "Pull to refresh"
        }
        return date.lastUpdatedFormattedText
    }
    
    // MARK: - LifeCycle
    
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
    
    func set(filterCountries: [Country]) {
        filterButtonAction = { [weak self] in
            let filterViewController = WeatherFilterViewController.instantiateFromStoryboard()
            filterViewController.items = filterCountries
            filterViewController.filterSetAction = { filterOption in
                self?.presenter.filter = filterOption
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
        var title: String
        switch filterOption {
        case .country(let country):
            title = "Filtered: \(country.name)"
        default:
            title = "Set Filter"
        }
        DispatchQueue.main.async {
            self.filterButton.setTitle(title, for: .normal)
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
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: lastUpdatedInfo)
        lastUpdatedDate = Date()
        
        presenter.refreshWeatherList { [weak self] in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self?.tableView.refreshControl?.alpha = 0
                    self?.tableView.refreshControl?.endRefreshing()
                }
                self?.tableView.refreshControl?.alpha = 1
            }
        }
    }
    
    func configAppearnce() {
        filterButton.setTitleColor(.gray, for: .normal)
        
        orderOptionButtonsAndIndicators.forEach { $0.button.setTitleColor(.gray, for: .normal) }
        
        highlight(orderOption: .alphabet)
    }
    
    func highlight(orderOption: OrderOption) {
        orderOptionButtonsAndIndicators.forEach {
            $0.button.alpha = 0.6
            $0.indicator.isHidden = true
        }
        
        switch orderOption {
        case .alphabet:
            alphabetOrderButton.alpha = 1
            alphabetOrderHighlightIndicatorView.isHidden = false
        case .temperature:
            temperatureOrderButton.alpha = 1
            temperatureOrderHighlightIndicatorView.isHidden = false
        case .lastUpdated:
            lastUpdatedOrderButton.alpha = 1
            lastUpdatedOrderrHighlightIndicatorView.isHidden = false
        }
    }
}
