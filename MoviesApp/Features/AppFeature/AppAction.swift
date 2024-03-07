//
//  AppAction.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

extension AppReducer {
    enum Action {
        case home(HomeReducer.Action)
    }
}
