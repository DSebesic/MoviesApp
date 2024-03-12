//
//  AppView.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import ComposableArchitecture
import SwiftUI

extension AppReducer {
    struct AppView: View {
        @Bindable var store: StoreOf<AppReducer>
        
        var body: some View {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                HomeReducer.HomeView(store: store.scope(state: \.homeState, action: \.home))
            } destination: { store in
                switch store.case {
                case .movieDetails(let store):
                    MovieDetailFeature.MovieDetailFeatureView(store: store)
                case .searchScreen(let store):
                    SearchFeature.SearchFeatureView(store: store)
                }
            }
        }
    }
}
