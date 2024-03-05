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
        var movies: [Movie] = []
        var moviesSortedByCategory: [Movie] = []
    }
    
    enum Action {
        case tabTapped(String)
        case viewAppeared
        case moviesResponse([Movie])
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabTapped(tab):
                state.activeTab = tab
                switch state.activeTab {
                    case "Now playing":
                        break
                    case "Upcoming":
                        state.movies = state.movies.sorted{ $0.releasedInt > $1.releasedInt }
                    case "Top rated":
                        state.movies = state.movies.sorted{ $0.metascoreInt > $1.metascoreInt }
                    case "Popular":
                        state.movies = state.movies.sorted{ $0.numOfRatingsInt > $1.numOfRatingsInt }
                    default:
                        break
                }
                
                return .none
            case .viewAppeared:
                return .run { send in
                    print("action started")
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "https://api.npoint.io/57bf829ba4493be4ea53")!)
                    print("Data gatherd")
                    let movies = try JSONDecoder().decode([Movie].self, from: data)
                    await send(.moviesResponse(movies))
                }
            case let .moviesResponse(movies):
                state.movies = movies
                state.isLoading = false
                return .none
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
            if store.state.isLoading {
                ProgressView()
                    .onAppear {
                        store.send(.viewAppeared)
                    }
            } else {
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
                            ForEach(store.state.movies) { movie in
                                AsyncImage(url: URL(string: movie.Images[0])){ image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }                            }
                            
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
                        ForEach(0..<2) { row in
                            GridRow {
                                ForEach(1..<4) { index in
                                    AsyncImage(url: URL(string: store.state.movies[index + 3*row].Poster)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
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
}

#Preview {
    HomeView(
        store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
        }
    )
}
