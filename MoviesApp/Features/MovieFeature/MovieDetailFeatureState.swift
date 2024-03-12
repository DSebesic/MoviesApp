import ComposableArchitecture

public extension MovieDetailFeature {
    @ObservableState
    struct State: Equatable {
        let movie: Movie
        var activeTab: DetailsTab = .AboutMovie
        init(movie: Movie) {
            self.movie = movie
        }
        
        public enum DetailsTab: CaseIterable, Equatable {
            case AboutMovie
            case Cast
            
            var title: String {
                switch self {
                case .AboutMovie:
                    "About Movie"
                case .Cast:
                    "Cast"
                }
            }
        }
    }
}
