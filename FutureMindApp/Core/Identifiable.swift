//
//  Identifiable.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

protocol Identifiable: AnyObject {
    
    static var identifier: String { get }
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
