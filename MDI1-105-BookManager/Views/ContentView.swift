//
//  ContentView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var books = getBooks()
    
    var body: some View {
        TabView {
            BookListView(books: $books)
            .tabItem {
                Label("Books", systemImage: "books.vertical.fill")
            }
            FavoritesView(books: $books)
                .tabItem{
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}

// jorge.marin@sdgku.edu
// Inbox in Canvas
