//
//  MovieCell.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/11/20.
//

import SwiftUI

struct MovieCell: View {
    var viewModel: MovieEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 5) {
                
                self.image(model: self.viewModel)
                
                self.overview(model: self.viewModel)
            }
        }
    }
    
    private var progressView: some View {
        ProgressView()
    }
    
    private func overview(model: MovieEntity) -> some View {
        VStack(spacing: 10) {
            Text(model.title)
                .font(.title)
                .font(.headline)
            
            Text(model.overview)
                .font(.subheadline)
                .lineLimit(5)
                .padding(.trailing, 5)
        }
    }
    
    private func image(model: MovieEntity) -> some View {
        guard let url = model.poster else {
            return self.progressView.eraseToAnyView

        }
        
        return AsyncImage(url: url,
                          placeholder: self.progressView,
                          configuration: { $0.resizable() })
            .aspectRatio(5/6, contentMode: .fit)
            .frame(minHeight: 80, idealHeight: 180, maxHeight: 200)
            .padding(.all, 5)
            .clipped()
            .eraseToAnyView
    }
}

