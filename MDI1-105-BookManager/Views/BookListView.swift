//
//  BookListView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI

struct BookListView: View {
    
    @Binding var books: [Book]
    @State var showEditView: Bool = false
    @State var newBook = Book()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($books, id: \.id) { $book in
                    NavigationLink(destination: BookDetailView(book: $book)) {
                        BookListItemView(book: book)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("My Books")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button("Add", action: {
                    newBook = Book()
                    showEditView.toggle()
                })
            )
            .sheet(isPresented: $showEditView) {
                AddEditBookView(book: $newBook) { savedBook in
                    if !books.contains(where: { $0.id == savedBook.id }) {
                        books.append(savedBook)
                    }
                }
            }
        }
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
    }
}
