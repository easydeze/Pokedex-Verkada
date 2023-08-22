import SwiftUI
struct PokedexView: View {
    @ObservedObject var viewModel = PokemonViewModel()

    var body: some View {
        VStack {
            if let selectedPokemon = viewModel.selectedPokemon {
                AsyncImage(url: selectedPokemon.sprites.front_default)
                    .frame(width: 100, height: 100)
            }

            List {
                ForEach(viewModel.pokemonListItems.indices, id: \.self) { index in
                    Text(viewModel.pokemonListItems[index].name.capitalized)
                        .onTapGesture {
                            viewModel.selectPokemon(viewModel.pokemonListItems[index])
                        }
                        .onAppear {
                            if index == viewModel.pokemonListItems.count - 1 {
                                viewModel.fetchPokemons()
                            }
                        }
                }
            }

            .onAppear(perform: viewModel.fetchPokemons)
        }
    }
}

struct AsyncImage: View {
    @State private var image: UIImage? = nil
    let url: String?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        image = nil
        guard let urlString = url, let imageURL = URL(string: urlString) else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
