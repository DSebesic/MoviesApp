import ComposableArchitecture

public struct SearchFeature: Reducer {
    
    public init() { }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
            case .viewAppeared, .binding:
                break
            case let .textSearched(text):
                state.searchText = text
                return .none
            case .showMovieDetails(_):
                return .none
            }
            return .none
        }
    }
}
