//
//  CountryDetailService.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation

protocol CountryDetailServiceProtocol: AnyObject {
    func getProvinceList(countryId: Int, completion: @escaping (_ success: Bool, _ results: ProvinceList?, _ error: Error?) -> ())
}

class CountryDetailService: CountryDetailServiceProtocol {
    func getProvinceList(countryId: Int, completion: @escaping (Bool, ProvinceList?, Error?) -> ()) {
        NetworkManager.shared.request(type: CountriesEndPoint.detail(id: countryId), modelType: ProvinceList.self) { response in
            completion(true, response, nil)
        } failure: { error in
            completion(false, nil, error)
        }
    }
}
