//
//  F.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public func toString(_ clas: AnyClass) -> String {
    return String(describing: clas)
}

public func toString<W>(_ type: W.Type) -> String {
    return String(describing: type)
}

public func toString<W>(for instance: W) -> String {
    return toString(type(of: instance))
}

public func cast<W, R>(_ value: W) -> R? {
    return value as? R
}
