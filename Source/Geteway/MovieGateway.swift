//
//  MovieGateway.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Combine

protocol MovieGateway {
    
    func retriveMovie(in category: TMDB,
                            page: Int) -> AnyPublisher<PaginationEntity<MovieEntity>, Error>
    
    func retriveMovieDetail(id: Int) -> AnyPublisher<MovieDetailEntity, Error>

}

class ApiMovieGatewayImpl: ApiBaseGateway, MovieGateway {
    
    public func retriveMovie(in category: TMDB,
                                   page: Int) -> AnyPublisher<PaginationEntity<MovieEntity>, Error>
    {
        let request = ExtendedApiRequest<PaginationEntity<MovieEntity>>.retriveMovie("/movie\(category.urlValue)", page: page)
        return self.apiClient.execute(request: request)
    }
    
    public func retriveMovieDetail(id: Int) -> AnyPublisher<MovieDetailEntity, Error> {
        let request = ExtendedApiRequest<MovieDetailEntity>.retriveDetail("/movie/\(id.description)")
        return self.apiClient.execute(request: request)
    }
}
