//
//  ErrorResponseHandler.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

struct ErrorResponseHandler: ResponseHandler {
    
    private let jsonDecoder = JSONDecoder()
    
    public func handle<T: Codable>(request: ApiRequest<T>,
                                   response: NetworkResponse,
                                   observer: @escaping (Result<T, Error>) -> Void) -> Bool {
        
        if let urlResponse = response.urlResponse,
           let nsHttpUrlResponse = urlResponse as? HTTPURLResponse,
           (300..<600).contains(nsHttpUrlResponse.statusCode) {
            
            var errorEntity = ResponseErrorEntity(response.urlResponse)
            
            errorEntity.errors.append("|| \(nsHttpUrlResponse.statusCode) ||\n")
            
            switch nsHttpUrlResponse.statusCode {
            case (300..<400):
                errorEntity.errors.append("Redirect Error.\n")
            case (400..<500):
                errorEntity.errors.append("Bad Request.\n")
            case (500..<600):
                errorEntity.errors.append("Server Error.\n")
            default:
                errorEntity.errors.append("Unknown Error.\n")
            }
            
            if response.data?.count == 0 {
                errorEntity.errors.append("Zero Data error")
            }
            
            observer(.failure(errorEntity))
            
            return true
        }
        
        return false
    }
}
