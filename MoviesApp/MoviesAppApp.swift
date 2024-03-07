//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Flabbergast on 04.03.2024..
//

import SwiftUI
import ComposableArchitecture


@main

struct MyApp: App {
    static let store = Store(initialState: AppReducer.State()) {
        AppReducer()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            AppReducer.AppView(store: MyApp.store)
        }
    }
}
