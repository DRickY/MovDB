//
//  ApiClient.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Combine

protocol ApiClient: AnyObject {
    
    var interceptors: [Interceptor] { set get }
    
    var responseHandlersQueue: [ResponseHandler] { set get }
    
    func execute<T: Codable>(request: ApiRequest<T>) -> AnyPublisher<T, Error>
}
