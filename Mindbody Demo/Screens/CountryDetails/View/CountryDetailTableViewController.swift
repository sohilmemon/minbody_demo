//
//  CountryDetailTableViewController.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import UIKit
import MapKit

class CountryDetailTableViewController: UITableViewController {

    //MARK: Properties
    private var mkMapView: MKMapView?
    private lazy var viewModel: CountryDetailViewModel = {
        return CountryDetailViewModel()
    }()
    private var country: CountryModel!
    private let mapViewHeight = 300.0
    
    convenience init(country: CountryModel) {
        self.init()
        self.country = country
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize Views and Data Models
        initialize()
    }

    private func initialize() {
        setupUI()
        startObservingEvents()
        fetchProvinces()
    }
    
    //MARK: UI Setup
    
    private func setupUI() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        self.title = country?.name.capitalized
        tableView.register(UINib(nibName: ProvinceTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ProvinceTableViewCell.identifier)
    }
    
    //MARK: API Calls & Data Handling

    @objc private func fetchProvinces() {
        //Fetch Countries Data
        if let countryId = country?.id {
            viewModel.getProvinceList(countryId)
        }
    }
    
    private func handleError(_ message: String) {
        self.showAlert(title: "Error", message: message, leftButtonTitle: "Retry", leftCompletionHandler: { _ in
            self.fetchProvinces()
        }, rightButtonTitle: "OK")
    }
    
    private func startObservingEvents() {
        viewModel.eventObserver = { [weak self] eventType in
            guard let self else { return }
            switch eventType {
            case .loading:
                self.showHUD(with: "Loading...")
            case .stopLoading:
                self.hideHUD()
            case .dataLoaded:
                self.updateTableView()
                self.updateMapView(for: self.country.name)
            case .error(let error):
                if let message = error?.localizedDescription {
                    self.handleError(message)
                }
            }
        }
    }
    
    private func updateTableView() {
        if viewModel.isProvinceListEmpty {
            tableView.setEmptyView(title: Constants.EmptyDataMessages.NoProvinceFound)
        } else {
            self.tableView.reloadData()
        }
    }
    
    private func updateMapView(for address: String) {
        viewModel.fetchLocationDetail(for: address.lowercased()) { [weak self] placemark in
            if let coordinate = placemark?.location?.coordinate, let radius = (placemark?.region as? CLCircularRegion)?.radius, let mkMapView = self?.mkMapView {
                mkMapView.setRegion(coordinates: coordinate, radius: radius)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProvincesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProvinceTableViewCell.identifier, for: indexPath) as! ProvinceTableViewCell
        cell.setupData(viewModel.getProvince(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = true
        let province = viewModel.getProvince(at: indexPath.row)
        self.updateMapView(for: province.name + ", " + country.name)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !viewModel.isProvinceListEmpty {
            mkMapView = MKMapView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.width, height: mapViewHeight)))
            return mkMapView
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.isProvinceListEmpty ? 0 : mapViewHeight
    }

}
