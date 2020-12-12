//
//  NetworkRequest.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

protocol NetworkRequest: AnyObject {
    var request: URLRequest { get }
}
