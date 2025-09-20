//
//  FavoritesView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @Binding var books: [Book]
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Computed Property
    private var favoriteBooks: [Binding<Book>] {
        $books.filter { $0.wrappedValue.isFavorite }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridLayout) {
                    ForEach(favoriteBooks, id: \.self.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            SquareCardView(book: book)
                        }
                    }
                }
            }
            .navigationBarTitle("My Favorite Books")
        }
    }
}
