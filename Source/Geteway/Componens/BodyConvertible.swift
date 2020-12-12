//
//  BodyConvertible.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

protocol BodyConvertible: AnyObject {
    func createBody() -> Data
}
