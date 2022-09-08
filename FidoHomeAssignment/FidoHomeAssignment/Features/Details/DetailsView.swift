//
//  DetailsView.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import SwiftUI

struct DetailsView: View {
    
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.system(.title).bold())
            
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .padding()
            }
            
            Text(article.articleDescription)
                .font(.system(.body))
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
