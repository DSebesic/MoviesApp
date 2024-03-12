//
//  HomeAction.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

extension HomeReducer {
    @CasePathable
    enum Action: Equatable {
        case tabTapped(HomeReducer.State.CategoryTab)
        case viewAppeared
        case moviesResponse([Movie])
        case searchTapped
        case movieTapped(Movie)
    }
}
