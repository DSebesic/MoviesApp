//
//  AppAction.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

extension AppReducer {
    @CasePathable
    enum Action {
        case home(HomeReducer.Action)
        case path(StackAction<Path.State, Path.Action>)
//        case binding(BindingAction<State>)
//        case movieDetail(MovieDetailFeature.Action)
    }
}
