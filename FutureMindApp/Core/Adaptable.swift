//
//  Adaptable.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 31/08/2021.
//

protocol Adaptable {
    associatedtype Model
    
    func adapt(model: Model)
}
