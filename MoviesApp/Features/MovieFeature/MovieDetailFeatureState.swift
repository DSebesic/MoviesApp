import ComposableArchitecture

public extension MovieDetailFeature {
    @ObservableState
    struct State: Equatable {
        let movie: Movie
        init(movie: Movie) {
            self.movie = movie
        }
    }
}
