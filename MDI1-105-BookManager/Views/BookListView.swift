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
    @State var isFilteringPresented: Bool = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    
    // Computed Property
    private var listBooks: [Binding<Book>] {
        $books.filter {
            (selectedGenre == nil || $0.wrappedValue.genre == selectedGenre)
            && (selectedStatus == nil || $0.wrappedValue.status == selectedStatus)
        }
    }
    
    var body: some View {
        NavigationStack {
            if (selectedGenre != nil || selectedStatus != nil) {
                Text("Current filter: \(selectedGenre?.rawValue ?? "All") Genre and \(selectedStatus?.rawValue ?? "All") Status")
            }
            List {
                ForEach(listBooks, id: \.id) { $book in
                    NavigationLink(destination: BookDetailView(book: $book)) {
                        BookListItemView(book: book)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("My Books")
            .navigationBarItems(
//                leading: EditButton(),
                leading: Button(action: {isFilteringPresented = true}) {
                    // Content of the button
                    Image(systemName: "line.horizontal.3.decrease.circle")
                },
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
            .sheet(isPresented: $isFilteringPresented) {
                FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus)
            }
        }
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
    }
}
