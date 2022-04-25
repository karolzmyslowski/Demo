//
//  JSONParser.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 15/08/2021.
//

import Foundation

public class JSONParser {
    
    private let decoder: JSONDecoder
    
    init() {
        self.decoder = JSONDecoder()
        decoder.dateDecodingStrategyFormatters = [.standard]
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T, Error> {
        do {
            let decodedObject = try decoder.decode(type.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(AppError.parsing)
        }
    }
}

