//
//  PopularViewModel.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/11/20.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    
    @Published private(set) var movies: [MovieEntity] = []
    
    @Published private(set) var error: Error?
    
    public var title: String { self.category.value.uppercased() }
    
    private var category: TMDB
    
    private var bag: AnyCancellable?
    
    private var currentPage = 1
    
    private let factory = Factory()
    
    let movieUseCase: MovieGateway
    
    init(movieUseCase: MovieGateway, category: TMDB) {
        self.movieUseCase = movieUseCase
        self.category = category
    }
    
    func fetchDatas() {
        let bag = self.movieUseCase
            .retriveMovie(in: self.category, page: self.currentPage)
            .sink { [weak self] comp in
                switch comp {
                case .failure(let error):
                    self?.reset()
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                self?.currentPage += 1
                self?.movies += values.items
            }
        
        self.bag = bag
    }
    
    func detailViewModel(id: Int) -> DetailMovieViewModel {
        return self.factory.detailViewModel(id: id)
    }
    
    func isLastItem(item: MovieEntity) -> Bool {
        return self.movies.isLastItem(item)
    }
    
    private func reset() {
        self.movies = []
        self.currentPage = 1
    }
}
