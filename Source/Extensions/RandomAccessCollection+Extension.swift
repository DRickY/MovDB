//
//  RandomAccessCollection+Extension.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/12/20.
//

import Foundation
import Combine

extension RandomAccessCollection where Self.Element: Identifiable {
    
    public func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !self.isEmpty else { return false }
        
        guard let itemIndex = self.lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: self.endIndex)
        return distance == 1
    }
}
