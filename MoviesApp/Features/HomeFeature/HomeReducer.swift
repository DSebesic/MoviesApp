//
//  HomeReducee.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeReducer {
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabTapped(tab):
                switch tab {
                case HomeReducer.State.CategoryTab.nowPlaying:
                    state.activeTab = .nowPlaying
                case HomeReducer.State.CategoryTab.upcoming:
                    state.activeTab = .upcoming
                case HomeReducer.State.CategoryTab.topRated:
                    state.activeTab = .topRated
                case HomeReducer.State.CategoryTab.popular:
                    state.activeTab = .popular
                }
                
                return .none
            case .viewAppeared:
                return fetchMovies(state: &state)
            case let .moviesResponse(movies):
                state.loadingValue = .loaded(movies)
                state.movies = movies
                return .none
            }
            return .none
        }
    }
    
    //    @Dependency(\.networking) var networking
    
    func fetchMovies(state: inout State) -> Effect<Action> {
        state.loadingValue = .loading
        return .run { send in
            //            networkin.fetchMovies()
            print("action started")
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "https://api.npoint.io/57bf829ba4493be4ea53")!)
            print("Data gatherd")
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            await send(.moviesResponse(movies))
        }
    }
}

