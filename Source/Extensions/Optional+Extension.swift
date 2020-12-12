//
//  Optional+Extension.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/12/20.
//

import Foundation

extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var isSome: Bool {
        return !self.isNil
    }

}
