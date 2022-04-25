//
//  ServiceProvider.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 15/08/2021.
//

import Foundation

protocol ServiceProviderProtocol {
    var urlComponents: RequestURLComponents { get }
    var http: HTTP { get }
    var taskService: TaskService { get }
}

class ServiceProvider: ServiceProviderProtocol {
    private let jsonParser: JSONParser
    let urlComponents: RequestURLComponents
    let http: HTTP
    let taskService: TaskService
    
    init() {
        self.jsonParser = JSONParser()
        self.urlComponents = RequestURLComponents(scheme: Constants.sheme, host: Constants.host)
        self.http = HTTP(jsonParser: jsonParser)
        self.taskService = TaskService(http: http, urlComponents: urlComponents)
    }
}
