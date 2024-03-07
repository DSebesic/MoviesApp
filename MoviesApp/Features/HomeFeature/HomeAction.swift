//
//  HomeAction.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation


extension HomeReducer {
    enum Action {
        case tabTapped(HomeReducer.State.CategoryTab)
        case viewAppeared
        case moviesResponse([Movie])
    }

}
