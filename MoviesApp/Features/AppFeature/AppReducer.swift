//
//  AppReducer.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppReducer {
    var body: some Reducer<State, Action> {
        Scope(state: \.homeState, action: \.home) {
            HomeReducer()
        }
        Reduce { state, action in
            switch action {
            case .home(.showMovieDetails(let movie)):
                state.path.append(.movieDetails(MovieDetailFeature.State(movie: movie)))
            case .home(.searchTapped):
                state.path.append(.searchScreen(SearchFeature.State(movies: state.homeState.movies)))
            default:
                break
            }
            return .none
        }
        .forEach(\.path, action: \.path)
    }
}

extension AppReducer {
    @Reducer(state:.equatable)
    public enum Path {
        case movieDetails(MovieDetailFeature)
        case searchScreen(SearchFeature)
    }
}
