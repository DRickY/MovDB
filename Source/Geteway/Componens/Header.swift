//
//  Header.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public struct Header {
    let key: String
    let value: String
}

public extension Header {
    static let contentJson = Header(key: "Content-Type", value: "application/json; charset=utf-8")
    static let acceptJson = Header(key: "Accept", value: "application/json")
}

public extension Array where Element == Header {

    func toMap() -> [String : String] {
        
        var map: [String: String] = [:]
        
        self.forEach { header in
            map[header.key] = header.value
        }
        
        return map
    }
}
