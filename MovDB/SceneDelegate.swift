//
//  SceneDelegate.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
//    var g: ApiSearchRepositoriesGatewayImpl!
//    var bag = Set<AnyCancellable>()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let host = Config.apiMovieEndpoint
        let apiClient: ApiClient = ApiClientImpl.defaultInstance(host: host)
        let apiService = ApiMovieGatewayImpl(apiClient)

        let popularVM = PopularViewModel(movieUseCase: apiService)
        let contentView = ContentView(viewModel: popularVM)
            
        popularVM.fetchDatas()
//            TabViewWrapper()
//            ContentView()
        
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            
            self.window = window
            
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

