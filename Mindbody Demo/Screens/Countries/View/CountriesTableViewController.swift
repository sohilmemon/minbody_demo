//
//  CountriesTableViewController.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import UIKit
import SDWebImage

class CountriesTableViewController: UITableViewController {
    
    //MARK: Properties
    private lazy var viewModel: CountriesViewModel = {
        return CountriesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize Views and Data Models
        initialize()
    }
    
    private func initialize() {
        setupUI()
        startObservingEvents()
        fetchCountries()
    }
    
    //MARK: UI Setup
    
    private func setupUI() {
        self.title = "Countries"
        setupRefreshControl()
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identifier)
    }
    
    private func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(fetchCountries), for: UIControl.Event.valueChanged)
    }
    
    private func stopRefreshing() {
        if self.refreshControl?.isRefreshing ?? false {
            self.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: API Calls & Data Handling

    @objc private func fetchCountries() {
        //Fetch Countries Data
        viewModel.getCountriesList()
    }
    
    private func handleError(_ message: String) {
        self.showAlert(title: "Error", message: message, leftButtonTitle: "Retry", leftCompletionHandler: { _ in
            self.fetchCountries()
        }, rightButtonTitle: "OK")
    }
    
    private func showDetailViewController(for country: CountryModel) {
        let countryDetailVC = CountryDetailTableViewController(country: country)
        self.navigationController?.pushViewController(countryDetailVC, animated: true)
    }
    
    private func startObservingEvents() {
        viewModel.eventObserver = { [weak self] eventType in
            guard let self else { return }
            switch eventType {
            case .loading:
                if !self.refreshControl!.isRefreshing {
                    self.showHUD(with: "Loading...")
                }
            case .stopLoading:
                if self.refreshControl!.isRefreshing {
                    self.refreshControl?.endRefreshing()
                } else {
                    self.hideHUD()
                }
            case .dataLoaded:
                self.tableView.reloadData()
            case .error(let error):
                if let message = error?.localizedDescription {
                    self.handleError(message)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountriesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as! CountryTableViewCell
        cell.setupData(viewModel.getCountry(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailViewController(for: viewModel.getCountry(at: indexPath.row))
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
