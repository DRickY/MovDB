//
//  DetailMovieView.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/12/20.
//

import SwiftUI

struct DetailMovieView: View {
    @ObservedObject var viewModel: DetailMovieViewModel
    
    var body: some View {
        self.content
            .onAppear { self.viewModel.fetchMovie() }
    }
    
    private var content: some View {
        switch viewModel.movieState {
        case .nop:
            return Color.clear.eraseToAnyView
        case .loading:
            return self.loader.eraseToAnyView
        case .loadedWithError(let error):
            return Text(error.localizedDescription).eraseToAnyView
        case .loaded(let movie):
            return self.movie(movie).eraseToAnyView
        }
    }
    
    var loader: some View {
        ProgressView()
    }
    
    private func movie(_ movie: MovieDetailEntity) -> some View {
        ScrollView() {
            VStack {
                
                Text(movie.title)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Released:")
                    Text(movie.release_date)
                }
                .font(.subheadline)
                
                self.poster(of: movie)
                
                Text(movie.overview)
                    .font(.body)
                    .padding(.all, 10)
            }
        }
    }
    
    private func poster(of movie: MovieDetailEntity) -> some View {
        movie.poster.map { url in
            AsyncImage(
                url: url,
                cache: nil,
                placeholder: self.loader,
                configuration: { $0.resizable() }
            )
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.size.width * 2/3)
            .cornerRadius(5)
            .padding(.all, 2)
        }
    }
}
