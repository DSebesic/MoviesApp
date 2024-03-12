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
        Scope(state: \.homeState, action: \.homeAction) {
            HomeReducer()
        }
//        Scope(state: \.searchState, action: \.searchAction) {
//            SearchFeature()
//        }
        Reduce { state, action in
            switch action {
            case .homeAction(.searchTapped):
                state.path.append(.searchScreen(SearchFeature.State(movies: state.homeState.movies)))
            case let .homeAction(.movieTapped(movie)):
                state.path.append(.movieDetails(MovieDetailFeature.State(movie: movie)))
            case let .path(.element(id: _, action: .searchScreen(.showMovieDetails(movie)))):
                state.path.append(.movieDetails(MovieDetailFeature.State(movie: movie)))
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
