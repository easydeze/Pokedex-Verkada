//class PokemonViewModel: ObservableObject {
@Published var pokemons = [PokemonListItem]()
@Published var selectedPokemon: Pokemon? = nil

let limit = 20
var offset = 0

func fetchPokemonList() {
    let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
    if let url = URL(string: urlString) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let decoder = JSONDecoder()
                if let pokemonList = try? decoder.decode(PokemonList.self, from: data) {
                    DispatchQueue.main.async {
                        self.pokemons.append(contentsOf: pokemonList.results)
                        self.offset += self.limit
                    }
                }
            }
        }.resume()
    }
}

func fetchPokemonDetail(name: String) {
    let detailURL = "https://pokeapi.co/api/v2/pokemon/\(name)"
    if let url = URL(string: detailURL) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let decoder = JSONDecoder()
                if let pokemon = try? decoder.decode(Pokemon.self, from: data) {
                    DispatchQueue.main.async {
                        self.selectedPokemon = pokemon
                    }
                }
            }
        }.resume()
    }
}
}
