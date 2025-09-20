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
        VStack {
            Text(book.title ?? "")
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Spacer()
            Text(book.author ?? "")
                .font(.subheadline)
                .lineLimit(1)
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(12)
    }
}
