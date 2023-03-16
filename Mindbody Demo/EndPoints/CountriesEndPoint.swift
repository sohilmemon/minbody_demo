//
//  CountriesEndPoint.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation
import Alamofire

enum CountriesEndPoint {
    case listing
    case detail(id: Int)
}

extension CountriesEndPoint: EndPointType {
    
    /// Creation of Endpoint Path using Query Params
    var path: String {
        switch self {
        case .listing:
            return "worldregions/country"
        case .detail(let id):
            return "worldregions/country/\(id)/province"
        }
    }
    
    /// Server Endpoing URL
    var baseUrl: String {
        return "https://connect.mindbodyonline.com/rest/"
    }
    
    /// Creation of Actual URL using BaseURL + Query Params
    var url: String {
        return "\(baseUrl)\(path)"
    }
    
    /// Type of Method to call the API
    var method: HTTPMethod {
        return .get
    }
    
    /// Headers needed to pass in the API calls
    var httpHeaders: HTTPHeaders? {
        return [
            "Content-Type" : "application/json"
        ]
    }
    
    /// API Calls with Params
    var params: [String : String]? {
        return nil
    }
}
