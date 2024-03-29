import SwiftUI
import ComposableArchitecture

public extension SearchFeature {
    struct SearchFeatureView: View {
        @Bindable var store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }
        
        public var body: some View {
            WithViewStore(store, observe: {$0}) { viewStore in
                ZStack {
                    Color.appBackground.ignoresSafeArea()
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("Search", text: $store.state.searchText)
                                .foregroundStyle(Color.appLightGray)
                                .padding(12)
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.appLightGray)
                                .padding(12)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.appDarkGray)
                        .cornerRadius(16)
                        .padding([.bottom], 8)
                        
                        if store.state.searchText == "" {
                            Spacer()
                                Text("Find your movie by Type title, categories, years, etc")
                                    .foregroundStyle(.appLightGray)
                                    .font(.system(size: 12))
                                    .padding(.horizontal, 32)
                        } else if store.state.movies.filter({ $0.Title.contains(store.state.searchText) }).count == 0 {
                            Spacer()
                            VStack(alignment: .center, spacing: 12) {
                                Image(.noResults)
                                Text("We are sorry, we can not find the movie :(")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16))
                                Text("Find your movie by Type title, categories, years, etc")
                                    .foregroundStyle(.appLightGray)
                                    .font(.system(size: 12))
                            }
                            .padding(.horizontal, 64)
                            .multilineTextAlignment(.center)
                        } else {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(store.state.movies.filter{ $0.Title.contains(store.state.searchText) }) { movie in
                                    VStack {
                                        MovieItem(movie: movie)
                                    }
                                    .onTapGesture {
                                        store.send(.showMovieDetails(movie))
                                    }
                                }
                            }
                        }
                        Spacer()
                            .foregroundColor(.white)
                    }
                    .padding(16)
                }
            }
        }
    }
}

#if debug
struct SearchFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFeature.SearchFeatureView(store: .init(initialState: .init(), reducer: .empty, environment: ()))
    }
}
#endif
