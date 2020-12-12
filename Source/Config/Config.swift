//
//  Config.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

struct Config {
    static var apiEndpoint = "https://api.themoviedb.org/3"
    static var apiImageURLEndpoint = "https://image.tmdb.org/t/p/w500"
    static var apiMovieEndpoint = Self.apiEndpoint + "/movie"
    
    static var apiKey = "851b6c550881fae0fa73c5d124c600ba"
}

public enum TMDBPath {
    case popular
    case topRated
    case upcoming
    
    var value: String {
        switch self {
        case .popular: return "/popular"
        case .topRated: return "/top_rated"
        case .upcoming: return "/upcoming"
        }
    }
}

extension QueryField {
    static let apiKey = QueryField(key: "api_key", value: Config.apiKey)
    static let defaultL10n = QueryField(key: "language", value: "en-US")
}
