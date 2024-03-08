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
        Scope(state: \.homeReducer, action: \.homeReducer) {
            HomeReducer()
        }
        Reduce { state, action in
            return .none
        }
    }
}
