import ComposableArchitecture

public extension SearchFeature {
    @CasePathable
    enum Action: BindableAction {
        case viewAppeared
        case binding(BindingAction<State>)
        case textSearched(String)
        case movieTapped(Movie)
    }
}
