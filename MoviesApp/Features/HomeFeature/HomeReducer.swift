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
                case "Now playing":
                    state.activeTab = .nowPlaying
                    break
                case "Upcoming":
                    state.activeTab = .upcoming
//                    state.movies = state.movies.sorted{ $0.releasedInt > $1.releasedInt }
                case "Top rated":
                    state.activeTab = .topRated
//                    state.movies = state.movies.sorted{ $0.metascoreInt > $1.metascoreInt }
                case "Popular":
                    state.activeTab = .popular
//                    state.movies = state.movies.sorted{ $0.numOfRatingsInt > $1.numOfRatingsInt }
                default:
                    break
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

