//
//  PaginationEntity.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public struct PaginationEntity<T: Codable>: Codable {
    
    let totalItems: Int
    
    let items: [T]
    
    init(totalItems: Int, items: [T]) {
        self.totalItems = totalItems
        self.items = items
    }
    
    private enum CodingKeys : String, CodingKey {
        case totalItems = "total_pages"
        case items = "results"
    }
}
