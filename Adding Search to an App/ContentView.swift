//
//  ContentView.swift
//  Adding Search to an App
//
//  Created by Eddington, Nick on 11/8/23.
//

import SwiftUI

struct Movie: Identifiable {
    var id = UUID()
    var title: String
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var movies: [Movie] = [
        Movie(title: "Inception"),
        Movie(title: "The Shawshank Redemption"),
        Movie(title: "The Godfather"),
        Movie(title: "Pulp Fiction"),
        Movie(title: "Fight Club"),
        Movie(title: "The Matrix"),
        Movie(title: "Forrest Gump"),
        Movie(title: "Gladiator"),
        Movie(title: "The Dark Knight"),
        Movie(title: "Schindler's List")
    ]
    
    @State private var initialSuggestions: [String] = []
    @State private var showSuggestions = false

    var body: some View {
        NavigationView {
            List {
                TextField("Search for a movie", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onTapGesture {
                        
                    }
                    .onSubmit {
                        showSuggestions = false
                    }
                    .foregroundColor(showSuggestions ? .blue : .primary) // Change text color
                
                if showSuggestions {
                    ForEach(initialSuggestions, id: \.self) { suggestion in
                        Button(action: {
                            searchText = suggestion
                            showSuggestions = false
                        }) {
                            Text(suggestion + " - Suggestion")
                        }
                        .foregroundColor(.blue) // Make suggestions blue
                    }
                }
                
                ForEach(filteredMovies, id: \.id) { movie in
                    Text(movie.title)
                }
            }
            .navigationBarTitle("Movie List")
        }
        .onAppear {
            initialSuggestions = movies.shuffled().prefix(3).map { $0.title }
            showSuggestions = true
        }
    }
    
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}


#Preview {
    ContentView()
}
