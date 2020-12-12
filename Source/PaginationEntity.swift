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
    
    var pageSize: Int { return 20 }
    
    var countOfPages: Int {
        return Int(ceil(Double(self.totalItems / self.pageSize)))
    }
    
    var currenPage: Int {
        return self.items.count / self.pageSize
    }
    
    var nextPage: Int {
        return self.countOfPages > self.currenPage ? self.currenPage + 1 : self.currenPage
    }

    init(totalItems: Int, itemsPerPage: Int, countOfPages: Int, items: [T]) {
        self.totalItems = totalItems
//        self.itemsPerPage = itemsPerPage
//        self.countOfPages = countOfPages
        self.items = items
    }
    
    init(totalItems: Int, items: [T]) {
        self.totalItems = totalItems
        self.items = items
    }

    
    private enum CodingKeys : String, CodingKey {
        case totalItems = "total_pages"
        case items = "results"
    }
}
