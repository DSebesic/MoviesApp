//
//  MoviesView.swift
//  MoviesApp
//
//  Created by Flabbergast on 06.03.2024..
//

import SwiftUI

struct MoviesView: View {
    @State var searchText = "Search"
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("What do you want to watch?")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                HStack {
                    TextField("Search", text: $searchText)
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
                        ForEach(store.state.movies) { movie in
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
                    ForEach(tabNames, id: \.self) { text in
                        VStack {
                            Text(text)
                                .onTapGesture {
                                    store.send(.tabTapped(text))
                                }
                            if store.activeTab == text {
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
                                AsyncImage(url: URL(string: store.state.movies[index + 3*row].Images[0])) { image in
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
    MoviesView()
}
