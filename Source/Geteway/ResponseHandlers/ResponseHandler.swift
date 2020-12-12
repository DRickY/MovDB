//
//  ResponseHandler.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public typealias NetworkResponse = (data: Data?, urlResponse: URLResponse?, error: Error?)

public protocol ResponseHandler {
    
    func handle<T: Codable>(request: ApiRequest<T>,
                            response: NetworkResponse,
                            observer: @escaping (Result<T, Error>) -> Void) -> Bool
}
