//
//  NetworkResponse.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 15/08/2021.
//

import Foundation

struct NetworkResponse {
    
    var data: Data?
    var httpHeader: [AnyHashable: Any]?
    var statusCode: Int
    
    var isSuccess: Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}
