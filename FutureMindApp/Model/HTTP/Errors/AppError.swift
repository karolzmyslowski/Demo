//
//  AppError.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

enum AppError: LocalizedError {
    case networkError
    case parsing
    case connectionError
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "network error"
        case .parsing:
            return "parsing"
        case .connectionError:
            return "connection error"
        }
    }
}
