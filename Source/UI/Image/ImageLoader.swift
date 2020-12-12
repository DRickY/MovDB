//
//  ImageLoader.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/12/20.
//

import UIKit
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private var cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        self.cancellable?.cancel()
    }
    
    func load() {
        guard !self.isLoading else { return }

        if let image = self.cache?[self.url] {
            self.image = image
            return
        }
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: self.url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        self.cancellable?.cancel()
    }
    
    private func onStart() {
        self.isLoading = true
    }
    
    private func onFinish() {
        self.isLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map { self.cache?[self.url] = $0 }
    }
}
