//
//  SquareCardView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI

struct SquareCardView: View {
    @Binding var book: Book
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background image
            Image(book.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            
            // Gradient overlay for readability
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                
                HStack {
                    Text("\(book.year!.description)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    
                    Spacer()
                    
                    // Rating stars
                    HStack(spacing: 2) {
                        ForEach(0..<5) { i in
                            Image(systemName: i < book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.caption2)
                        }
                    }
                }
            }
            .padding(8)
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(2)
    }
}
