//
//  Factory.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/12/20.
//

import Foundation

struct Factory {
    
    var movieService: MovieGateway {
        let host = Config.apiEndpoint
        let apiClient: ApiClient = ApiClientImpl.defaultInstance(host: host)
        return ApiMovieGatewayImpl(apiClient)
    }

    func detailViewModel(id: Int) -> DetailMovieViewModel {
        return DetailMovieViewModel(movieUseCase: movieService, id: id)
    }
    
    func listViewModel(category: TMDB) -> ListViewModel {
        return .init(movieUseCase: self.movieService, category: category)
    }
    
}
