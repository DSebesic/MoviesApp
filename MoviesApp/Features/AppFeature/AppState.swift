//
//  AppState.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

extension AppReducer {
    @ObservableState
    struct State: Equatable {
        var homeState = HomeReducer.State()
        var path = StackState<Path.State>()
//        var movieDetail: MovieDetailFeature.State?
    }
}
