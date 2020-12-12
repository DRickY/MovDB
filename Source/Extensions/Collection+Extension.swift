//
//  Collection+Extension.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
