//
//  ProvinceModel.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation

struct ProvinceModel: Codable {
    let id: Int
    let countryCode: String
    let code, name: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case countryCode = "CountryCode"
        case code = "Code"
        case name = "Name"
    }
}

typealias ProvinceList = [ProvinceModel]
