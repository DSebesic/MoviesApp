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
        let store: StoreOf<AppReducer>
        
        var body: some View {
            HomeReducer.HomeView(store: store.scope(state: \.home, action: \.home))
        }
    }
}
