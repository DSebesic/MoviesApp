import ComposableArchitecture

public struct MovieDetailFeature: Reducer {

    public init() { }

    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce<State, Action> { state, action in
            switch action {
                case .viewAppeared, .binding:
                    break
            case let .tabTapped(tab):
                state.activeTab = tab
            }
            return .none
        }
    }
}
