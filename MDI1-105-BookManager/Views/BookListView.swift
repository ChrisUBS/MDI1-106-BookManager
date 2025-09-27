//
//  BookListView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI

struct BookListView: View {
    
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_RATING_KEY) var showRating: Bool = SETTINGS_SHOW_RATING_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_LIST_GRID_KEY) var showListGrid: Bool = SETTINGS_SHOW_LIST_GRID_DEFAULT_VALUE
    @Binding var books: [Book]
    @State var showEditView: Bool = false
    @State var newBook = Book()
    @State var isFilteringPresented: Bool = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    
    // Computed Properties
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
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
            if (showListGrid) {
                ScrollView {
                    LazyVGrid(columns: gridLayout) {
                        ForEach(listBooks, id: \.self.id) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                SquareCardView(book: book, showRating: showRating)
                            }
                        }
                    }
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
            } else {
                List {
                    ForEach(listBooks, id: \.id) { $book in
                        NavigationLink(destination: BookDetailView(book: $book)) {
                            BookListItemView(book: book, showRating: showRating)
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
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
    }
}
