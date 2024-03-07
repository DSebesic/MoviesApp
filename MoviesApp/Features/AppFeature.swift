//
//  AppFeature.swift
//  MoviesApp
//
//  Created by Flabbergast on 05.03.2024..
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    struct State {
        var homeFeature = HomeReducer.State()
    }
    
    enum Action {
        case homeFeature(HomeReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.homeFeature, action: \.homeFeature) {
            HomeReducer()
        }
        Reduce { state, action in
            return .none
        }
    }
}

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        HomeReducer.HomeView(store: store.scope(state: \.homeFeature, action: \.homeFeature))
    }
}

#Preview {
    AppView(
        store: Store(initialState: AppFeature.State()) {
            AppFeature()
        }
    )
}
