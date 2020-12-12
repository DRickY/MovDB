//
//  ApiClientImpl.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation
import Combine

/*
 public class ApiClientImp: ApiClient {

     private let urlSession: URLSessionProtocol
     public var timeoutScheduler = MainScheduler.instance
     public var dispatchQueue = SerialDispatchQueueScheduler(qos: .default,
                                                             internalSerialQueueName: "network_queue")

     public var interceptors = [Interceptor]()
     public var responseHandlersQueue = [ResponseHandler]() // При добавлением обработчиков в список, важно учитывать порядок, в котором они будут вызываться


     public init(urlSessionConfiguration: URLSessionConfiguration,
                 completionHandlerQueue: OperationQueue) {
         urlSession = URLSession(configuration: urlSessionConfiguration,
                                 delegate: nil,
                                 delegateQueue: completionHandlerQueue)
     }

     public init(urlSession: URLSessionProtocol) {
         self.urlSession = urlSession
     }

     public func execute<T>(request: ApiRequest<T>) -> Single<T> {
         return Single.create { (observer: @escaping (SingleEvent<T>) -> ()) in
                     self.prepare(request)

                     let dataTask: URLSessionDataTask = self.urlSession
                             .dataTask(with: request.request) { (data, response, error) in

                         self.preHandle(request, (data, response, error))
                         var isHandled = false
                         for handler in self.responseHandlersQueue {
                             if isHandled {
                                 break
                             }
                             isHandled = handler.handle(observer: observer,
                                                        request: request,
                                                        response: (data, response, error))
                         }
                         if !isHandled {
                             let errorEntity = ResponseErrorEntity(response)
                             errorEntity.errors.append(
                                     "Внутренняя ошибка приложения: не найдет обработчик ответа от сервера")
                             observer(.error(errorEntity))
                         }
                     }
             
                     dataTask.resume()
                     return Disposables.create {
                         dataTask.cancel()
                     }
                 }
                 .subscribeOn(dispatchQueue)
                 .observeOn(dispatchQueue)
                 .timeout(request.responseTimeout, scheduler: timeoutScheduler)
                 .do(onError: { error in print("network error:", error.localizedDescription) })
     }

     /// Вызывается перед тем, как обработается ответ от сервера.
     ///
     /// - Parameter response: Полученный ответ.
     private func preHandle<T: Codable>(_ request: ApiRequest<T>, _ response: NetworkResponse) {
         interceptors.forEach { interceptor in
             interceptor.handle(request: request, response: response)
         }
     }

     /// Вызывается перед тем, как будет отправлен запрос к серверу.
     ///
     /// - Parameter request: Запрос, который отправляется.
     private func prepare<T>(_ request: ApiRequest<T>) {
         interceptors.forEach { interceptor in
             interceptor.prepare(request: request)
         }
     }

     public static func defaultInstance(host: String) -> ApiClientImp {
         ApiEndpoint.baseEndpoint = ApiEndpoint(host)
         let apiClient = ApiClientImp(urlSession: URLSession.shared)
         apiClient.interceptors.append(LoggingInterceptor())
         apiClient.responseHandlersQueue.append(JsonResponseHandler())
         return apiClient
     }
 }
 */

class ApiClientImpl: ApiClient {

    private let urlSession: URLSessionProtocol
    
    private let dispatchQueue = DispatchQueue(label: "network_queue")
    
    var interceptors: [Interceptor] = []
    
    var responseHandlersQueue: [ResponseHandler] = []

    public init(urlSessionConfiguration: URLSessionConfiguration, queue: OperationQueue) {
        self.urlSession = URLSession(configuration: urlSessionConfiguration,
                                     delegate: nil, delegateQueue: queue)
    }
    
    public init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func execute<T: Codable>(request: ApiRequest<T>) -> AnyPublisher<T, Error> {
        self.prepare(request: request)

        return Deferred {
            return Future<T, Error> { (promise) in
                
                let dataTask = self.urlSession.dataTask(with: request.request,
                                                        completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                                                            
                            self.preHandle(request: request, response: (data, response, error))
                            
                            var isHandled = false
                            
                            for handler in self.responseHandlersQueue {
                                if isHandled { break }
                                
                                isHandled = handler.handle(request: request,
                                                           response: (data, response, error),
                                                           observer: promise)
                            }

                            if !isHandled {
                                var errorEntity = ResponseErrorEntity(response)
                                errorEntity.errors.append(
                                    "Internal application error: server response handler not found")
                                errorEntity.errors.append((error?.localizedDescription) ?? "")
                                promise(.failure(errorEntity))
                            }
                        })
                
                dataTask.resume()
            }
        }
        .subscribe(on: self.dispatchQueue)
        .receive(on: OperationQueue.main)
        .timeout(.seconds(request.responseTimeout), scheduler: OperationQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func prepare<T: Codable>(request: ApiRequest<T>) {
        self.interceptors.forEach {
            $0.prepare(request: request)
        }
    }
    
    private func preHandle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {
        self.interceptors.forEach {
            $0.handle(request: request, response: response)
        }
    }
    
    public static func defaultInstance(host: String) -> ApiClient {
        ApiEndpoint.baseEndpoint = ApiEndpoint(host: host)
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        let client = ApiClientImpl(urlSession: session)
        client.responseHandlersQueue.append(ErrorResponseHandler())
        client.responseHandlersQueue.append(JsonResponseHandler())
        
        return client
    }
}
