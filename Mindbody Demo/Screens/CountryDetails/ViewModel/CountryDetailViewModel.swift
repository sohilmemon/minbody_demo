//
//  CountryDetailViewModel.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation
import CoreLocation

class CountryDetailViewModel: NSObject {
    
    //MARK: Properties
    var eventObserver: ((_ event : ViewModelObservableEvent) -> Void)?
    private var provinceList: ProvinceList = []
    private var countryDetailService: CountryDetailServiceProtocol
    var isProvinceListEmpty: Bool {
        get {
            return provinceList.isEmpty
        }
    }
    
    /// Initialize the class with service callign
    init(countryDetailService: CountryDetailServiceProtocol = CountryDetailService()) {
        self.countryDetailService = countryDetailService
    }
    
    /// Function to fetch provinces list from web server
    func getProvinceList(_ countryId: Int) {
        eventObserver?(.loading)
        countryDetailService.getProvinceList(countryId: countryId) { [weak self] success, results, error in
            guard let self else { return }
            self.eventObserver?(.stopLoading)
            if success, let countries = results {
                self.provinceList = countries
                self.eventObserver?(.dataLoaded)
            } else {
                self.eventObserver?(.error(error))
            }
        }
    }
    
    /// Return the total number of count of provinces
    func getProvincesCount() -> Int {
        return provinceList.count
    }
    
    /// Return the country data as per the passed index
    func getProvince(at index: Int) -> ProvinceModel {
        return provinceList[index]
    }
    
    /// Fetch Location Coordinates from given Address
    func fetchLocationDetail(for address: String, completion: @escaping ((CLPlacemark?) -> ())) {
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            completion(placemarks?.first)
        }
    }
}
