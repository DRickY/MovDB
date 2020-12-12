//
//  RepositoriesPagination.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation
import Combine

//protocol RepositoriesPagination {
//
//    var source: PassthroughSubject<[MovieEntity], Never> { get }
//    
//    var limit: Int { get set }
//
//    var isLoadingInProcess: Bool { get }
//
//    func hasMorePage() -> Bool
//    
//    func loadNewData(searchBy text: String)
//    
//    func reset()
//
//    func reloadPage(text: String, from page: Int)
//}
//
//class RepositoriesPaginationImp: RepositoriesPagination {
//
//    public var limit: Int = 15
//    
//    var source = PassthroughSubject<[MovieEntity], Never>()
//    
//    private var countItemsLastLoadedPage: Int = 0
//    
//    public var isLoadingInProcess: Bool = false
//
//    private let searchGateway: SearchRepositoriesGateway
//
//    private var currentPage = 1
//    
//    private var totalItemsCount: Int?
//    
//    private var items = [MovieEntity]()
//
//    private var nextPage: Int {
//        let result = self.currentPage + 1
//        self.currentPage = result
//        return result
//    }
//
//    init(searchGateway: SearchRepositoriesGateway) {
//        self.searchGateway = searchGateway
//    }
//
//    public func hasMorePage() -> Bool {
//
//        guard let totalItemsCount = self.totalItemsCount else {
//            return true
//        }
//
//        return self.items.count < totalItemsCount
//    }
//
//    public func loadNewData(searchBy text: String) {
//        guard !self.isLoadingInProcess else {
//            print("LOADING IN PROCESS")
//            return }
//
////        self.source
////            .handleEvents(receiveSubscription: <#T##((Subscription) -> Void)?##((Subscription) -> Void)?##(Subscription) -> Void#>,
////                                 receiveOutput: <#T##(([MovieEntity]) -> Void)?##(([MovieEntity]) -> Void)?##([MovieEntity]) -> Void#>,
////                                 receiveCompletion: <#T##((Subscribers.Completion<Never>) -> Void)?##((Subscribers.Completion<Never>) -> Void)?##(Subscribers.Completion<Never>) -> Void#>,
////                                 receiveCancel: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>,
////                                 receiveRequest: <#T##((Subscribers.Demand) -> Void)?##((Subscribers.Demand) -> Void)?##(Subscribers.Demand) -> Void#>)
//            
//        self.cancelLoading()
//        self.isLoadingInProcess = true
////        self.source.send([])
//
////        self.searchGateway.searchRepositories(category: .popular, page: nextPage, observer: <#T##(Result<PaginationEntity<MovieEntity>, ResponseErrorEntity>) -> Void#>)
//        
////        self.searchGateway.searchRepositories(text: text,
////                                                    currentPage: self.nextPage,
////                                                    limit: self.limit,
////                                                    { [weak self] (result) in
////
////                                                        switch result {
////                                                        case .success(let values):
////                                            //                self.currentPage += 1
////                                                            self?.totalItemsCount = values.totalItems
////                                                            self?.countItemsLastLoadedPage = values.items.count
////                                                            self?.items.append(contentsOf: values.items)
////                                                            self?.isLoadingInProcess = false
////
////                                                            self?.observer?(.success(self!.items))
////
////                                                        case .failure(let error):
////                                                            self?.isLoadingInProcess = false
////                                                            DispatchQueue.main.async {
////                                                                self?.observer?(.failure(error))
////                                                            }
////
////                                                            print("Pagination: catch error =", error.localizedDescription)
////                                                        }
////                                                    })
//    }
//
//    public func reset() {
//        self.items.removeAll()
//        self.totalItemsCount = nil
//        self.currentPage = 1
//        self.countItemsLastLoadedPage = 0
//    }
//
//    public func reloadPage(text: String, from page: Int) {
//        
//        let currentLoadedPage = 1
////            self.currentPage.value == 1 ? 1 : self.currentPage.mutate {
////            $0 = $0 - 1
////            return $0
////        }
//
//        let itemsForRemove = self.countItemsLastLoadedPage + (currentLoadedPage - page) * self.limit
//        self.items.removeLast(itemsForRemove)
//        self.currentPage = 1
//
////        self.observer.map { self.loadNewData(searchBy: text, startLoading: self.startLoading, observer: $0) }
//    }
//
//    private func cancelLoading() {
//    }
//}
