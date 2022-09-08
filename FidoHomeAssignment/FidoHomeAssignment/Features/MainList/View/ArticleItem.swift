//
//  ArticleItem.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import SwiftUI

struct ArticleItem: View {
    
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(article.title)
                .font(.system(.subheadline).bold())
            Text("Author: \(article.author ?? "")")
                .font(.system(.caption))
                .foregroundColor(.secondary)            
            Divider()

        }
        .padding(.horizontal)
    }
}
