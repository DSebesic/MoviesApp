import ComposableArchitecture

public extension MovieDetailFeature {
    @CasePathable
    enum Action: BindableAction {
        case viewAppeared
        case binding(BindingAction<State>)
    }
}
