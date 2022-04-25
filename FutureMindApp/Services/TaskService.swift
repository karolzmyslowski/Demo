//
//  TaskService.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

class TaskService {
    
    typealias TaskResponse = (Result<[Task], Error>) -> ()
    
    var http: HTTP
    var urlComponents: RequestURLComponents
    
    private var request: Request {
        var request = Request(urlComponents: urlComponents)
        request.endpoint = .main
        return request
    }
    
    init(http: HTTP, urlComponents: RequestURLComponents) {
        self.http = http
        self.urlComponents = urlComponents
    }
    
    func getTasks(completion: @escaping TaskResponse) {
        http.makeRequestAndParse(request, completion: completion)
    }
}
