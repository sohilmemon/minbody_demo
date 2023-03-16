//
//  NetworkManager.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation
import Alamofire

/// Response Decoding Type Generic Handler
typealias ReponseSuccessHandler<T: Decodable> = ((T) -> Void)

/// Response Failure Handler
typealias ReponseFailureHandler = ((Error) -> Void)

class NetworkManager {
    
    //Singleton Instance
    static let shared = NetworkManager()
    
    //Private Init - To stop create objects of class
    private init(){}
    
    /// No Internet Connection Custom Error
    private lazy var noInternetConnectionError: Error = {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: 100, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.NoInternetConnection])
    }()
    
    func request<T: Decodable>(type: EndPointType,
                               modelType : T.Type,
                               success: @escaping ReponseSuccessHandler<T>,
                               failure: @escaping ReponseFailureHandler) {
        
        /// Checking for Internet Connection Availibility
        if Reachability.isInternetAvailable {
            /// Calling of Network request
            AF.request(type.url, method: type.method, parameters: type.params, encoding: JSONEncoding.default, headers: type.httpHeaders).responseDecodable(of: modelType, completionHandler: { response in
                switch response.result {
                case .success(let data):
                    success(data.self)
                case let .failure(error):
                    failure(error)
                }
            })
        } else {
            failure(noInternetConnectionError)
        }
    }
}
