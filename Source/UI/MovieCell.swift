//
//  MovieCell.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/11/20.
//

import SwiftUI

struct MovieCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 0) {
                
//                    GeometryReader { geo in
                    Image("xmax") //poster-placeholder
                        .resizable()
                        .aspectRatio(5/6, contentMode: .fit)
//                            .aspectRatio(CGSize(width: 3, height: 7), contentMode: .fill)
                        .frame(height: 100) //width: geo.size.width,

                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 5)
                        .clipped()
//                            .border(Color.green)
//                    }
                
                VStack(spacing: 10) {
                    Text("Jiu Jitsu")
                    Text("A young elf mistakes a tiny alien for a Christmas gift, not knowing her new plaything has plans to destroy Earth\'s gravity — and steal all the presents")
                        .font(.custom("helvetica", size: 9))
                        .lineLimit(5)
//                            .padding(.trailing, 5)
                }
                
            }
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }

    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell().frame(width: 414, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
