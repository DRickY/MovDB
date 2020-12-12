//
//  Interceptor.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public protocol Interceptor: AnyObject {
    
    func prepare<T: Codable>(request: ApiRequest<T>)

    func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse)
}
