//
//  HomeFeature.swift
//  MoviesApp
//
//  Created by Flabbergast on 04.03.2024..
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        var activeTab: String = "Now playing"
        var isLoading: Bool = true
        var movies: 
    }
    
    enum Action {
        case tabTapped(String)
        case moviesFetched
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabTapped(tab):
                state.activeTab = tab
                return .none
            case .moviesFetched:
                
            }
            return .none
        }
    }
}

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    let tabNames: [String] = ["Now playing", "Upcoming", "Top rated", "Popular"]
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("What do you want to watch?")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchText)
                        .padding(8)
                        .foregroundColor(.primary)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(8)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12, content: {
                        ForEach(1..<10) { _ in
                            Image(.movie1)
                                .resizable()
                                .scaledToFit()
                        }
                        
                    })
                    .frame(maxHeight: 250)
                }
                Spacer()
                HStack {
                    ForEach(tabNames, id: \.self) { text in
                        if store.activeTab == text {
                            Text(text)
                                .onTapGesture {
                                    store.send(.tabTapped(text))
                                }
                                .overlay(
                                    Rectangle()
                                        .fill(Color.appDarkGray)
                                        .frame(width: 90, height: 4),
                                    alignment: .bottom
                                )
                        } else {
                            Text(text)
                                .onTapGesture {
                                    store.send(.tabTapped(text))
                                }
                        }
                    }
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                Grid {
                    ForEach(1..<3) { _ in
                        GridRow {
                            ForEach(1..<4) { _ in
                                Image(.movie1)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(16)
        }
        
    }
}

#Preview {
    HomeView(
        store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
        }
    )
}
