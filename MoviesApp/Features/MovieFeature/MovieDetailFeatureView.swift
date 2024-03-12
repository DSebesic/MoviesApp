import SwiftUI
import ComposableArchitecture

public extension MovieDetailFeature {
    struct MovieDetailFeatureView: View {
        let store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }

        public var body: some View {
            WithViewStore(store, observe: {$0} ) { viewStore in
                Text("MovieDetailFeatureView")
                    .onAppear {
                        viewStore.send(.viewAppeared)
                    }
            }
        }
    }
}

#if debug
struct MovieDetailFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailFeature.MovieDetailFeatureView(store: .init(initialState: .init(), reducer: .empty, environment: ()))
    }
}
#endif
