import SwiftUI
import ComposableArchitecture

public extension MovieDetailFeature {
    struct MovieDetailFeatureView: View {
        let store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }
        
        public var body: some View {
            WithViewStore(store, observe: {$0}) { viewStore in
                ZStack {
                    Color.appBackground.ignoresSafeArea()
                    VStack {
                        VStack {
                            AsyncImage(url: URL(string: store.state.movie.Images[0])) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        HStack() {
                            Text(store.state.movie.Title)
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(12)
                        HStack {
                            Image(.calendarBlank)
                            Text(store.state.movie.Released)
                            Divider()
                                .frame(width: 1, height: 16)
                                .overlay(.appLightGray)
                            Image(.clock)
                            Text(store.state.movie.Runtime)
                            Divider()
                                .frame(width: 1, height: 16)
                                .overlay(.appLightGray)
                            Image(.ticket)
                            Text(store.state.movie.Genre.components(separatedBy: ", ")[0])
                        }
                        .padding(.horizontal, 24)
                        .foregroundStyle(.appLightGray)
                        .font(.system(size: 12))
                        Spacer()
                    }
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
