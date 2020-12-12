//
//  DetailMovieViewModel.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/12/20.
//

import Foundation
import Combine

class DetailMovieViewModel: ObservableObject {
    
    @Published private(set) var movieState: State
    
    private let movieUseCase: MovieGateway
    
    private var detailID: Int {
        if case .nop(id: let id) = self.movieState {
            return id
        }
        return 0
    }
    
    private var bag: AnyCancellable?
    
    init(movieUseCase: MovieGateway, id: Int) {
        self.movieUseCase = movieUseCase
        self.movieState = .nop(id: id)
    }
    
    func fetchMovie() {
        
        let bag = self.movieUseCase
            .retriveMovieDetail(id: self.detailID)
            .handleEvents(receiveSubscription: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.movieState = .loading
                }
            })
            .sink { [weak self] in
                switch $0 {
                case .failure(let error):
                    self?.movieState = .loadedWithError(error)
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] movie in
                self?.movieState = .loaded(movie)
            }
        
        self.bag = bag
    }
}

extension DetailMovieViewModel {
    enum State {
        case nop(id: Int)
        case loading
        case loadedWithError(Error)
        case loaded(MovieDetailEntity)
    }
}


