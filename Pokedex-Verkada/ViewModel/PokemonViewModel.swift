import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    @Published var selectedPokemon: Pokemon?

    private var currentPage = 0
    private let itemsPerPage = 20
    private var canLoadMore = true

    // Fetch the list of pokemons
    func fetchPokemons() {
        guard canLoadMore else { return }
        
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(itemsPerPage)&offset=\(currentPage)"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                        DispatchQueue.main.async {
                            self.pokemons.append(contentsOf: pokemonList.results)
                            self.currentPage += self.itemsPerPage
                            
                            if pokemonList.results.count < self.itemsPerPage {
                                self.canLoadMore = false
                            }
                        }
                    } catch {
                        print("Error decoding Pokemon list: \(error)")
                    }
                }
            }
            task.resume()
        }
    }

    // Fetch the details of a specific pokemon
    func fetchPokemonDetails(for pokemonItem: PokemonListItem) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemonItem.name)"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let pokemonDetails = try JSONDecoder().decode(Pokemon.self, from: data)
                        DispatchQueue.main.async {
                            self.selectedPokemon = pokemonDetails
                        }
                    } catch {
                        print("Error decoding Pokemon details: \(error)")
                    }
                }
            }
            task.resume()
        }
    }

    // Check if more data needs to be loaded
    func checkAndLoadMoreData(currentItem: PokemonListItem) {
        if let lastItem = pokemons.last, lastItem.name == currentItem.name {
            fetchPokemons()
        }
    }
}
