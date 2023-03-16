//
//  CountriesViewModel.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation

class CountriesViewModel: NSObject {
    
    //MARK: Properties
    var eventObserver: ((_ event : ViewModelObservableEvent) -> Void)?
    private var countriesList: CountriesList = []
    private var countryService: CountriesServiceProtocol
    
    /// Initialize the class with service callign
    init(countryService: CountriesServiceProtocol = CountriesService()) {
        self.countryService = countryService
    }
    
    /// Function to fetch countries list from web server
    func getCountriesList() {
        eventObserver?(.loading)
        countryService.getCountriesList { [weak self] success, results, error in
            guard let self else { return }
            self.eventObserver?(.stopLoading)
            if success, let countries = results {
                self.countriesList = countries
                self.eventObserver?(.dataLoaded)
            } else {
                self.eventObserver?(.error(error))
            }
        }
    }
    
    /// Return the total number of count of countries
    func getCountriesCount() -> Int {
        return countriesList.count
    }
    
    /// Return the country data as per the passed index
    func getCountry(at index: Int) -> CountryModel {
        return countriesList[index]
    }
}
