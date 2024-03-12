
import SwiftUI

struct ActorItem: View {
    @State var actor: String
    var body: some View {
        HStack(spacing: 16) {
            Image(.ellipse)
            Text(actor)
            Spacer()
        }
    }
}

#Preview {
    MovieItem()
}
