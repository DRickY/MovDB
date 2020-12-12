//
//  JsonResponseHandler.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public struct JsonResponseHandler: ResponseHandler {
    
    private let decoder = JSONDecoder()
    
    public init() {}

    public func handle<T: Codable>(request: ApiRequest<T>,
                                   response: NetworkResponse,
                                   observer: @escaping (Result<T, Error>) -> Void) -> Bool {
        if let data = response.data {
            do {
                if T.self == Data.self {
                    observer(.success(data as! T))
                } else {
                    let result = try decoder.decode(T.self, from: data)
                    observer(.success(result))
                }
            } catch {
                var err = ResponseErrorEntity()
                err.errors.append(error.localizedDescription)
                observer(.failure(err))
            }
            return true
        }

        return false
    }
}
