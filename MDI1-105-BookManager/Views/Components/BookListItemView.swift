//
//  BookListItemView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI

struct BookListItemView: View {
    
    var book: Book
    
    var body: some View {
        HStack {
            Image(book.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 48, maxHeight: 48)
            VStack(alignment: .leading) {
                Text(book.title)
                Text(book.description)
                    .font(.system(size: 12))
                    .padding(.leading, 5)
            }
        }
    }
}
