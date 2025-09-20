//
//  BookDetailView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var book: Book
    @State private var showingEdit = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(alignment: .top, spacing: 16) {
                    Image(book.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("by \(book.author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(book.description)
                            .font(.body)
                            .padding(.top, 4)
                    }
                    Spacer()
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Review")
                        .font(.headline)
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    Text(book.review)
                        .font(.body)
                        .padding(.top, 4)
                }
                HStack {
                    Spacer()
                    Toggle(isOn: $book.isFavorite) {
                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                            .renderingMode(.original)
                    }
                    .toggleStyle(.button)
                    .font(.title)
                    .accessibilityLabel(book.isFavorite ? "Remove from favorites" : "Add to favorites")
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEdit = true
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            EditBookView(book: $book)
        }
    }
}

