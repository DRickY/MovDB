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
            Text("Popular tab view")
              .tabItem {
                 Text("Popular Tab")
               }

            Text("Upcoming tab view")
                .tabItem {
                    Text("Upcoming")
            }
            
            Text("Top Rated tab view")
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
