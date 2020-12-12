//
//  RepositoryEntity.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

struct MovieEntity: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    
    var poster: URL? {
        return self.poster_path.flatMap {
            return URL(string: Config.apiImageURLEndpoint.appending($0))
        }
    }
}

