//
//  Request.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

public struct RequestURLComponents {
    public typealias SettingsValueFetchBlock = () -> String?
    
    var scheme: String
    var host: String
    
    public init(
        scheme: String,
        host: String) {
        self.scheme = scheme
        self.host = host
    }
}

public struct Request {
    
    var urlComponents: RequestURLComponents
    var endpoint: Endpoint?
    var method: HTTPMethod = .get
    
    var url: URL? {
        guard let requestEndpoint = endpoint?.url else { return nil }
        let url = urlComponents.scheme + urlComponents.host + requestEndpoint
        guard let endpoint = URL(string: url) else { return nil }
        
        return URL(string: endpoint.absoluteString)
    }
    
    public init(urlComponents: RequestURLComponents) {
        self.urlComponents = urlComponents
    }
    
}
