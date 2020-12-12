//
//  AsyncImage.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/11/20.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    
    @ObservedObject private var loader: ImageLoader
    
    private let placeholder: Placeholder?
    private let configuration: (Image) -> Image
    
    init(url: URL, cache: ImageCache? = nil, placeholder: Placeholder? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        self.loader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
        self.configuration = configuration
    }
    
    var body: some View {
        self.image
            .onAppear(perform: self.loader.load)
            .onDisappear(perform: self.loader.cancel)
    }
    
    private var image: some View {
        Group {
            if self.loader.image != nil {
                self.configuration(Image(uiImage: self.loader.image!))
            } else {
                self.placeholder
            }
        }
    }
}


