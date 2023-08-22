import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var selectedPokemon: Pokemon?

    private var numPokemon = 0 // Number of pokemon currently processed.
    private let numNext = 20 // Setting the limit of the request.
    private var canLoad = true // Determine whether we can load more pokemon.

    // Fetch the list of pokemons
    func fetchPokemon() {
        guard canLoad else { return } // Break out
        
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(numNext)&offset=\(numPokemon)" // Call the PokeAPI.
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                        DispatchQueue.main.async {
                            if pokemonList.results.count < self.numNext {
                                self.canLoad = false // Reached the limit
                            }
                            
                            self.pokemonList.append(contentsOf: pokemonList.results)
                            self.numPokemon += self.numNext
                        }
                    } catch {
                        print("Error with fetching list: \(error)")
                    }
                }
            }
            task.resume()
        }
    }

    // Get the details of a particular pokemon.
    func fetchPokemonDetails(for pokemonItem: PokemonListItem) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemonItem.name)" // Use PokeAPI to get specific pokemon.
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let pokemonDetails = try JSONDecoder().decode(Pokemon.self, from: data)
                        DispatchQueue.main.async {
                            self.selectedPokemon = pokemonDetails
                        }
                    } catch {
                        print("Error with fetching detail: \(error)")
                    }
                }
            }
            task.resume()
        }
    }

    // There is more pokemon data to load if we reach the last pokemon.
    func checkAndLoadMoreData(currPoke: PokemonListItem) {
        if let lastPoke = pokemonList.last, lastPoke.name == currPoke.name {
            fetchPokemon()
        }
    }
}
