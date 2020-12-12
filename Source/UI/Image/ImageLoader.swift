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
    
    private var cancellable: AnyCancellable?
    
    private var cache: ImageCache?
    
    private(set) var isLoading = false
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    private let url: URL?

    init(url: URL?, cache: ImageCache) {
        self.url = url
        self.cache = cache
    }

    deinit {
        self.cancel()
    }
    
    func load() {
        guard !self.isLoading else { return }

        if let url = self.url, let image = self.cache?[url] {
            self.image = image
            return
        }
        
        self.cancellable = self.url.map(URLSession.shared.dataTaskPublisher(for: ))?
            .subscribe(on: Self.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    private func cache(_ image: UIImage?) {
        if let url = self.url, let img = image {
            self.cache?[url] = img
        }
    }

    private func onStart() {
        self.isLoading = true
    }
    
    private func onFinish() {
        self.isLoading = false
    }


    func cancel() {
        self.cancellable?.cancel()
    }
}
