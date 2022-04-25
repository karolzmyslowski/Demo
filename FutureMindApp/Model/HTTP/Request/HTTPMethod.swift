//
//  HTTPMethod.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

enum HTTPMethod {
    case get
    
    var string: String {
        switch self {
        case .get: return "GET"
        }
    }
}
