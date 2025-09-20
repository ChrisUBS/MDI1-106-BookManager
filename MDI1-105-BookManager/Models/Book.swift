//
//  Book.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import Foundation

struct Book: Identifiable, Hashable {
    var id = UUID()
    var title: String = ""
    var image: String = "default_book"
    var description: String = ""
    var author: String = ""
    var year: Int? = nil
    var category: String = ""
    var rating: Int = 0
    var review: String = ""
    var status: String = "Planned"
    var isFavorite: Bool = false
}
