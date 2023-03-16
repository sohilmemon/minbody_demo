//
//  EndPointType.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation
import Alamofire

/// Endpoint Construction
protocol EndPointType {
    var path: String { get }
    var baseUrl: String { get }
    var url: String { get }
    var method: HTTPMethod { get }
    var httpHeaders: HTTPHeaders? { get }
    var params: [String : String]? { get }
}
