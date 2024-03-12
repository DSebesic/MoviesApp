import ComposableArchitecture

public extension SearchFeature {
    @ObservableState
    struct State: Equatable {
        var searchText: String = ""
        let movies: [Movie]
        init(movies: [Movie]) {
            self.movies = movies
        }
    }
}
