//
//  MovieDetailsViewModel.swift
//  TestFilmesMock
//
//  Created by Allan Melo on 05/02/20.
//  Copyright © 2020 Allan Melo. All rights reserved.
//

import SwiftUI

class MovieDetailsViewModel: ObservableObject {
    enum State {
        case loading
        case done
        case error
        
        var isLoading: Bool {
            self == .loading
        }
    }
    
    let movieId: Int
    @Published var state: State = .done
    @Published var movie: Movie?
    var didUpdate: () -> () = {}
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func loadContent() {
        guard !state.isLoading else { return }
        
        state = .loading
        let url = URL(string: "http://www.allan.com/filmes/\(movieId)")!
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                let movie = try? JSONDecoder().decode(Movie.self, from: data)
            else {
                DispatchQueue.main.async {
                    self?.state = .error
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self?.movie = movie
                self?.state = .done
                self?.didUpdate()
            }
            
        }.resume()
    }
}
