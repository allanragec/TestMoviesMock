//
//  MoviesListViewModel.swift
//  TestFilmesMock
//
//  Created by Allan Melo on 05/02/20.
//  Copyright © 2020 Allan Melo. All rights reserved.
//

import SwiftUI

class MoviesListViewModel: ObservableObject {
    enum State {
        case loading
        case done
        case error
        
        var isLoading: Bool {
            self == .loading
        }
    }
    
    @Published var state: State = .done
    var didUpdate: () -> () = {}
    var movies = [Movie]()
    
    func loadContent() {
        guard !state.isLoading else { return }
        
        state = .loading
        let url = URL(string: "http://www.allan.com/filmes")!
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                let movies = try? JSONDecoder().decode([Movie].self, from: data)
            else {
                DispatchQueue.main.async {
                    self?.state = .error
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self?.movies = movies
                self?.state = .done
                self?.didUpdate()
            }
            
        }.resume()
    }
}
