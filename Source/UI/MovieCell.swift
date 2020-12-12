//
//  MovieCell.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/11/20.
//

import SwiftUI

struct MovieCell: View {
    var viewModel: MovieEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 5) {
                AsyncImage(url: self.viewModel.imageURL, placeholder: {
                    Text("Image Loading")
                }, image: {
                    Image.init(uiImage: $0)
                        .resizable()
                })
                    .aspectRatio(5/6, contentMode: .fit)
                    .frame(minHeight: 80, idealHeight: 180, maxHeight: 200)
                    .padding(.all, 5)
                    .clipped()
                
                VStack(spacing: 10) {
                    Text(self.viewModel.title)
                        .font(.title)
                        .font(.headline)
                        
                    Text(self.viewModel.description)
                        .font(.subheadline)
                        .lineLimit(5)
                        .padding(.trailing, 5)
                }
            }
        }
    }
}

//struct MovieCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieCell(viewModel: .init(title: "Jes2", descriptin: "this results in an invalid NSError instance. It will raise an exception in a future release. Please call errorWithDomain:code:userInfo: or initWithDomain:code:userInfo:. This message shown only once.", poster: nil))
//    }
//}
