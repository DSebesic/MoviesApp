//
//  MovieItem.swift
//  MoviesApp
//
//  Created by Flabbergast on 08.03.2024..
//

import SwiftUI

struct MovieItem: View {
    @State var movie: Movie?
    var body: some View {
        HStack {
            if let unWrappedMovie = movie {
                AsyncImage(url: URL(string: unWrappedMovie.Images[0])) { image in
                    image
                        .resizable()
                        .frame(width: 150.0, height: 115.0)
                        .cornerRadius(16.0)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(unWrappedMovie.Title)
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(.star)
                        Text(unWrappedMovie.imdbRating)
                            .font(.system(size: 12))
                            .foregroundStyle(.appSecondary)
                    }
                    HStack(spacing: 4) {
                        Image(.calendarBlank)
                        Text(unWrappedMovie.Released)
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                    }
                    HStack(spacing: 4) {
                        Image(.clock)
                        Text(unWrappedMovie.Runtime)
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxHeight: .infinity)
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    MovieItem()
}
