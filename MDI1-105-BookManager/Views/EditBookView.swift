//
//  EditBookView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 14/09/25.
//

import SwiftUI

struct EditBookView: View {
    @Binding var book: Book
    @Environment(\.dismiss) var dismiss
    @State private var draftBook: Book
    
    let statuses = ["Planned", "Reading", "Finished"]
    
    init(book: Binding<Book>) {
        self._book = book
        self._draftBook = State(initialValue: book.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("BOOK DETAILS") {
                    TextField("Title", text: $draftBook.title)
                    TextField("Author", text: $draftBook.author)
                    
                    Picker("Status", selection: $draftBook.status) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status)
                        }
                    }
                    
                    TextField("Description", text: $draftBook.description)
                }
                
                Section("MY RATING & REVIEW") {
//                    Stepper("Rating: \(draftBook.rating, specifier: "%.1f")", value: $draftBook.rating, in: 0...5, step: 0.5)
                    StartRatingView(rating: $draftBook.rating)
                    
                    TextEditor(text: $draftBook.review)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Edit Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        book = draftBook
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
