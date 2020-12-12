//
//  TabViewWrapper.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import SwiftUI

struct TabViewWrapper: View {
    
    var body: some View {
        
        TabView {
            MovieListView(viewModel: Factory().listViewModel(category: .popular))
              .tabItem {
                 Text("Popular")
               }

            MovieListView(viewModel: Factory().listViewModel(category: .upcoming))

                .tabItem {
                    Text("Upcoming")
            }
            
            MovieListView(viewModel: Factory().listViewModel(category: .topRated))
                .tabItem {
                    Text("Top Rated")
            }
        }
    }
}

struct TabViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        TabViewWrapper()
    }
}
