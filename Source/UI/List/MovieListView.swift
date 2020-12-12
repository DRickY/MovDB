//
//  ContentView.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import SwiftUI

struct MovieListView: View {    
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        
        if self.viewModel.error.isSome {
            return Text(self.viewModel.error!.localizedDescription).eraseToAnyView
        }
        
        if self.viewModel.movies.isEmpty {
            return ProgressView("Loading data, please wait")
                .onAppear(perform: {
                    self.viewModel.fetchDatas()
                }).eraseToAnyView
        }
        
        return NavigationView {
            self.movies(movies: self.viewModel.movies)
            .navigationTitle(self.viewModel.title)
        }.eraseToAnyView
    }
    
    
    
    private func movies(movies: [MovieEntity]) -> some View {
        List(movies) { model in
            NavigationLink(destination: DetailMovieView(viewModel: self.viewModel.detailViewModel(id: model.id))) {
                VStack {
                    
                    MovieCell(viewModel: model)
                    
                    if self.viewModel.isLastItem(item: model) {
                        Divider()
                        Text("Load new batch")
                            .padding(.vertical)
                            .onAppear {
                                self.viewModel.fetchDatas()
                        }
                    }
                }
            }
        }
    }
}
