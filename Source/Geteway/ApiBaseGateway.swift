//
//  ApiBaseGateway.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public class ApiBaseGateway {
    
    let apiClient: ApiClient
    
    init(_ client: ApiClient) {
        self.apiClient = client
    }
}
