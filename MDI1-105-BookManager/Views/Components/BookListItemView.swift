//
//  BookListItemView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI

struct BookListItemView: View {
    
    var book: Book
    var showRating: Bool
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomLeading) {
                Image(book.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 48, maxHeight: 48)
                
                if book.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(2)
                        .clipShape(Circle())
                        .offset(x: 25, y: -4)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                if !book.description.isEmpty {
                    Text(book.description)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                if (showRating) {
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}
