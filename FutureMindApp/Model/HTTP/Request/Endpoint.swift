//
//  Endpoint.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 15/08/2021.
//

import Foundation

public enum Endpoint {
    
    case main

    public var url: String {
        switch self {
        case .main: return "recruitment-task"
        }
    }
}
