//
//  FilterView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 23/09/25.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var selectedGenre: Genre?
    @Binding var selectedStatus: ReadingStatus?
    
    var body: some View {
        Form {
            Section(header: Text("Filter by genre")) {
                Picker("Genre", selection: $selectedGenre) {
                    Text("Select a genre").tag(nil as Genre?)
                    ForEach(Genre.allCases) { genre in
                        Text(genre.displayName).tag(genre)
                    }
                }
            }
            
            Section(header: Text("Filter by reading status")) {
                Picker("Status", selection: $selectedStatus) {
                    Text("Select a status").tag(nil as ReadingStatus?)
                    ForEach(ReadingStatus.allCases) { status in
                        Text(status.displayName).tag(status)
                    }
                }
            }
        }
    }
}
