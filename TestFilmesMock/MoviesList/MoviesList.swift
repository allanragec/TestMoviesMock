//
//  MoviesList.swift
//  TestFilmesMock
//
//  Created by Allan Melo on 10/12/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import SwiftUI

struct Movie: Codable {
    let id: Int
    let name: String
    let description: String
}

struct MoviesList: View {
    @ObservedObject var viewModel = MoviesListViewModel()
    
    var body: some View {
            NavigationView {
                self.contentView
                    .modifier(PullToRefreshModifier(onRefresh: { self.viewModel.loadContent() }))
                    .onPreferenceChange(RefreshViewPrefKey.self, perform: { pullToRefresh in
                        self.viewModel.didUpdate = {
                            pullToRefresh?.endRefreshing()
                        }
                    })
                    .navigationBarTitle("Movies")
                    .onAppear(perform: self.viewModel.loadContent)
            }
    }
    
    func errorView() -> AnyView {
        VStack {
            Text("Could not load data")
            Button("Reload data") { self.viewModel.loadContent() }
        }.typeErased
    }
    
    fileprivate func listView() -> AnyView {
        List {
            ForEach(viewModel.movies, id: \.id) { movie in
                NavigationLink(destination: MovieDetails(movieId: movie.id)) {
                    Text(movie.name)
                }
            }
        }.typeErased
    }
    
    var contentView: some View {
        switch viewModel.state {
        case .loading, .done:
            return listView()
        case .error:
            return errorView()
        }
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
