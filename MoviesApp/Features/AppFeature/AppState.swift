//
//  AppState.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

extension AppReducer {
    struct State {
        var homeReducer = HomeReducer.State()
    }
}
