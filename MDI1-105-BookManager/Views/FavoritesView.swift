//
//  FavoritesView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    @Binding var books: [Book]
    @State var isFilteringPresented: Bool = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    
    // Computed Properties
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
    private var favoriteBooks: [Binding<Book>] {
        $books.filter {
            $0.wrappedValue.isFavorite
            && (selectedGenre == nil || $0.wrappedValue.genre == selectedGenre)
            && (selectedStatus == nil || $0.wrappedValue.status == selectedStatus)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if (selectedGenre != nil || selectedStatus != nil) {
                    Text("Current filter: \(selectedGenre?.rawValue ?? "All") Genre and \(selectedStatus?.rawValue ?? "All") Status")
                }
                LazyVGrid(columns: gridLayout) {
                    ForEach(favoriteBooks, id: \.self.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            SquareCardView(book: book)
                        }
                    }
                }
            }
            .navigationBarTitle("My Favorite Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {isFilteringPresented = true}) {
                        // Content of the button
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                    .accessibilityLabel("Open filter options")
                }
            }
            .sheet(isPresented: $isFilteringPresented) {
                FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus)
            }
        }
    }
}
