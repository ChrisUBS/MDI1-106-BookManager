//
//  BookListView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI

struct BookListView: View {
    
    @Binding var books: [Book]
    @State var showAddView: Bool = false
    @State var newBook = Book(title: "New", description: "new book", author: "somebody", year: 2000, category: "Classic", rating: 3, review: "Nice book", status: "Reading")
    
    var body: some View {
        NavigationStack {
            List($books, id: \.self.id) { $book in
                NavigationLink(destination: BookDetailView(book: $book)) {
                    BookListItemView(book: book)
                }
            }
            .navigationBarTitle("My Books")
            .navigationBarItems(trailing: Button("Add", action: {
                showAddView.toggle()
            }))
            .sheet(
                isPresented: $showAddView,
                onDismiss: {
                    let _ = print("This is dismissed")
                },
                content: {
                    EditBookView(book: $newBook)
                }
            )
        }
    }
}
