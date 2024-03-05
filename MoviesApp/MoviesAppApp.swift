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
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: MyApp.store)
        }
    }
}
