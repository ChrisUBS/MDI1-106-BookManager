//
//  EditBookView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 14/09/25.
//

import SwiftUI

struct AddEditBookView: View {
    @Binding var book: Book
    var onSave: (Book) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var draftBook: Book
    @State private var navigationTitle: String
    
    let statuses = ["Planned", "Reading", "Finished"]
    
    init(book: Binding<Book>, onSave: @escaping (Book) -> Void) {
        self._book = book
        self._draftBook = State(initialValue: book.wrappedValue)
        self._navigationTitle = State(initialValue: book.wrappedValue.title.isEmpty ? "Add a new book" : "Edit book")
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("BOOK DETAILS") {
                    TextField("Title", text: $draftBook.title)
                    TextField("Author", text: $draftBook.author)
                    
                    TextField("Year", text: Binding(
                            get: { draftBook.year.map { String($0) } ?? "" },
                            set: { draftBook.year = Int($0) }
                        ))
                        .keyboardType(.numberPad)
                    
                    Picker("Genre", selection: $draftBook.genre) {
                        ForEach(Genre.allCases) { genre in
                            Text(genre.displayName)
                        }
                    }

                    Picker("Status", selection: $draftBook.status) {
                        ForEach(ReadingStatus.allCases) { status in
                            Text(status.displayName)
                        }
                    }
                    
                    TextField("Description", text: $draftBook.description)
                }
                
                Section("MY RATING & REVIEW") {
                    StartRatingView(rating: $draftBook.rating)
                    
                    TextEditor(text: $draftBook.review)
                        .frame(height: 100)
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        book = draftBook
                        onSave(draftBook)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
