import ComposableArchitecture

public extension MovieDetailFeature {
    struct State: Equatable {
        let movie: Movie
        init(movie: Movie) {
            self.movie = movie
        }
    }
}
