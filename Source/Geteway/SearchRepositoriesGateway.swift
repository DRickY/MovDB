//
//  SearchRepositoriesGateway.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Combine

public protocol MovieGateway {
    func retrive(in category: TMDBPath,
                            page: Int) -> AnyPublisher<PaginationEntity<MovieEntity>, Error>
}

public class ApiMovieGatewayImpl: ApiBaseGateway, MovieGateway {
    
    public func retrive(in category: TMDBPath,
                                   page: Int) -> AnyPublisher<PaginationEntity<MovieEntity>, Error>
    {
        let request = ExtendedApiRequest<PaginationEntity<MovieEntity>>.retrive(category: category.value, page: page)
        return self.apiClient.execute(request: request)
    }
}
