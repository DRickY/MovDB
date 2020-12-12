//
//  MovieDetailEntity.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/12/20.
//

import Foundation

public struct MovieDetailEntity: Codable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
    
    var poster: URL? {
        return URL(string: Config.apiImageURLEndpoint.appending(self.poster_path))
    }
}
