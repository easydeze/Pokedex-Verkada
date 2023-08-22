import SwiftUI
struct SelectedPokemonView: View {
    let pokemon: Pokemon?

    var body: some View {
        if let imageUrlString = pokemon?.sprites.front_default {
            AsyncImage(url: imageUrlString)
                .frame(width: 100, height: 100)
        } else {
            EmptyView()
        }
    }
}
