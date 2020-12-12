//
//  ApiEndpoint.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public struct ApiEndpoint {
    
    public static var baseEndpoint: ApiEndpoint!

    let host: String
    
    init(host: String) {
        self.host = host
    }
}
