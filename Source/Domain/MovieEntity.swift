//
//  RepositoryEntity.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public struct MovieEntity: Codable, Identifiable {
    public let id: Int
    let title: String
    let description: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "overview"
        case poster = "poster_path"
    }
}

