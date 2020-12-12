//
//  ContentView.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import SwiftUI

struct ContentView: View {    
    @ObservedObject var viewModel: PopularViewModel
    
    var body: some View {
        if viewModel.data.isEmpty {
            Text("Loading data, please wait")
        }
        
        List(self.viewModel.data) { model in
            VStack {
                MovieCell(viewModel: model)
                
                if self.viewModel.data.isLastItem(model) {
                    Divider()
                    Text("Load new batch")
                        .padding(.vertical)
                }
            }
        }
        .onAppear(perform: {
            print("OnApper")
        })
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: .init())
//    }
//}
