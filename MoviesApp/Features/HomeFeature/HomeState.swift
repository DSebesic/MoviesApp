//
//  HomeState.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture

extension HomeReducer {
    @ObservableState
    struct State: Equatable {
        enum LoadingValue: Equatable {
            case idle
            case loading
            case failed
            case loaded([Movie])
        }
        
        public enum CategoryTab: CaseIterable, Equatable {
            case nowPlaying
            case upcoming
            case topRated
            case popular
        }
                
        var loadingValue: LoadingValue = .idle
        var activeTab: CategoryTab = .nowPlaying
        var movies: [Movie] = []
        var searchText: String = "Search"
    }
}


