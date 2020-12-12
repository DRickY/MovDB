//
//  PopularViewModel.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/11/20.
//

import Foundation
import Combine

class PopularViewModel: ObservableObject {
    
    @Published var data: [MovieEntity] = []
    
    private var bag = Set<AnyCancellable>()
    
    let movieUseCase: MovieGateway
    
    init(movieUseCase: MovieGateway) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchDatas() {
        self.movieUseCase.retrive(in: .popular, page: 1)
            .sink { [weak self] in
                switch $0 {
                case .failure(let error):
                    self?.reset()
                    print("failed: \(error)")
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] values in
                self?.data += values.items
            }
            .store(in: &bag)
    }
    
    private func reset() {
        self.data = []
    }
}


extension MovieEntity {
    // hardcoded
    var imageURL: URL? {
        if self.poster != "" {
            return URL(string: Config.apiImageURLEndpoint + poster)
        }
        
        return nil
    }
}
