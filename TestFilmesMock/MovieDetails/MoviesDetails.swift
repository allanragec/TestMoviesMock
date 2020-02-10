//
//  MoviesDetails.swift
//  TestFilmesMock
//
//  Created by Allan Melo on 10/12/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import SwiftUI

struct MovieDetails: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    init(movieId: Int) {
        self.viewModel = MovieDetailsViewModel(movieId: movieId)
    }
    
    var body: some View {
        contentView
            .modifier(PullToRefreshModifier(onRefresh: { self.viewModel.loadContent() }))
            .onPreferenceChange(RefreshViewPrefKey.self, perform: { pullToRefresh in
                self.viewModel.didUpdate = {
                    pullToRefresh?.endRefreshing()
                }
            })
            .navigationBarTitle(viewModel.movie?.name ?? "")
            .onAppear(perform: self.viewModel.loadContent)
    }
    
    func errorView() -> AnyView {
        VStack {
            Text("Could not load data")
            Button("Reload data") { self.viewModel.loadContent() }
        }.typeErased
    }
    
    func movieView() -> AnyView {
        Form {
            Text(viewModel.movie?.description ?? "")
        }.typeErased
    }
    
    var contentView: some View {
        switch viewModel.state {
        case .loading, .done:
            return movieView()
        case .error:
            return errorView()
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList()
    }
}
