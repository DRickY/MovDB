//
//  AsyncImage.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/11/20.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    
    @StateObject private var loader: ImageLoader
    
    private let image: (UIImage) -> Image
    
    private let placeholder: Placeholder
    
    init(url: URL?, @ViewBuilder placeholder: () -> Placeholder, @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self.placeholder = placeholder()
        self.image = image
        let c = Environment(\.imageCache).wrappedValue
        self._loader = StateObject(wrappedValue: ImageLoader(url: url, cache: c))
    }
    
    var body: some View {
        self.content
            .onAppear(perform: self.loader.load)
        //            .onDisappear(perform: self.loader.cancel)
    }
    
    private var content: some View {
        Group {
            if self.loader.image != nil {
                self.image(self.loader.image!)
            } else {
                self.placeholder
            }
        }
    }
}

