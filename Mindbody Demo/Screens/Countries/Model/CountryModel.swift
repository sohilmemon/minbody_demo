//
//  CountryModel.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation

// MARK: - CountryModel
struct CountryModel: Codable {
    let id: Int
    let name, code: String
    let phoneCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case code = "Code"
        case phoneCode = "PhoneCode"
    }
}

typealias CountriesList = [CountryModel]
