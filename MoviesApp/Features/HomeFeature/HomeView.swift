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
        @Bindable var store: StoreOf<HomeReducer>
        
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
                                    .foregroundStyle(Color.appLightGray)
                                    .padding(12)
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.appLightGray)
                                    .padding(12)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.appDarkGray)
                            .cornerRadius(16)
                            .padding([.bottom], 8)
                            .onTapGesture {
                                store.send(.searchTapped)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12, content: {
                                    ForEach(movies) { movie in
                                        AsyncImage(url: URL(string: movie.Images[0])){ image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .onTapGesture {
                                                    store.send(.movieTapped(movie))
                                                }
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
                                        Text(tabCategory.title)
                                            .onTapGesture {
                                                store.send(.tabTapped(tabCategory))
                                            }
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                            .fontWeight(tabCategory.title == store.state.activeTab.title ? .bold : nil)
                                            .overlay(tabCategory.title == store.state.activeTab.title ? Rectangle()
                                                .fill(Color.appDarkGray)
                                                .frame(width: 90, height: 4)
                                                .offset(y: 20) : nil, alignment: .bottom)
                                    }
                                }
                            }
                            .foregroundColor(.white)
                            Spacer()
                            Grid {
                                ForEach(0..<2) { row in
                                    GridRow {
                                        ForEach(1..<4) { index in
                                            AsyncImage(url: URL(string: movies[index + 3*row].Images[0])) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .onTapGesture {
                                                        store.send(.movieTapped(movies[index + 3*row]))
                                                    }
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
