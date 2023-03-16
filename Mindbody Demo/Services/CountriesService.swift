//
//  CountriesService.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation

protocol CountriesServiceProtocol: AnyObject {
    func getCountriesList(completion: @escaping (_ success: Bool, _ results: CountriesList?, _ error: Error?) -> ())
}

class CountriesService: CountriesServiceProtocol {
    func getCountriesList(completion: @escaping (_ success: Bool, _ results: CountriesList?, _ error: Error?) -> ()) {
        NetworkManager.shared.request(type: CountriesEndPoint.listing, modelType: CountriesList.self) { response in
            completion(true, response, nil)
        } failure: { error in
            completion(false, nil, error)
        }
    }
}
