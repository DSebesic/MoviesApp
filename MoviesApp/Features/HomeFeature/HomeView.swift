//
//  HomeView.swift
//  MoviesApp
//
//  Created by Flabbergast on 07.03.2024..
//

import Foundation
import SwiftUI
import ComposableArchitecture


extension HomeReducer {
    struct HomeView: View {
        let store: StoreOf<HomeReducer>
        
        var body: some View {
            WithViewStore(store, observe: \.loadingValue) { viewStore in
                ZStack {
                    switch viewStore.state {
                    case .loading:
                        ProgressView()
                            .onAppear { store.send(.viewAppeared) }
                    case .failed:
                        EmptyView()
                        //TODO
                    case .loaded(let movies):
                        Color.appBackground.ignoresSafeArea()
                        VStack(alignment: .leading) {
                            Text("What do you want to watch?")
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            HStack {
                                Text("Search")
                                    .padding(8)
                                    .background(Color.appDarkGray)
                                    .foregroundStyle(Color.appLightGray)
                                    .cornerRadius(16)
                                    .overlay(Image(systemName: "magnifyingglass")
                                        .foregroundColor(.appLightGray), alignment: .trailing)
                            }
                            .padding(8)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12, content: {
                                    ForEach(movies) { movie in
                                        AsyncImage(url: URL(string: movie.Images[0])){ image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    
                                })
                                .frame(maxHeight: 250)
                            }
                            Spacer()
                            HStack {
                                ForEach(State.CategoryTab.allCases, id: \.self) { tabCategory in
                                    VStack {
                                        Text("TODO")
                                            .onTapGesture {
                                                store.send(.tabTapped(tabCategory))
                                            }
                                        if store.activeTab == tabCategory {
                                            Rectangle()
                                                .fill(Color.appDarkGray)
                                                .frame(width: 90, height: 4)
                                        }
                                    }
                                }
                            }
                            .foregroundColor(.white)
                            Grid {
                                ForEach(0..<2) { row in
                                    GridRow {
                                        ForEach(1..<4) { index in
                                            AsyncImage(url: URL(string: movies[index + 3*row].Images[0])) { image in
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
                    case .idle:
                        ProgressView()
                            .onAppear { store.send(.viewAppeared) }
                    }
                }
            }
        }
    }
}
