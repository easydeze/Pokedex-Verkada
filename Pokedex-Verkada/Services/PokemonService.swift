//import Foundation
//
//class PokemonService {
//    let baseURL = "https://pokeapi.co/api/v2/pokemon"
//
//    func fetchPokemons(offset: Int, limit: Int, completion: @escaping ([Pokemon]?) -> ()) {
//        let urlString = "\(baseURL)?limit=\(limit)&offset=\(offset)"
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, _, _ in
//            if let data = data {
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(PokemonListResponse.self, from: data)
//                    let group = DispatchGroup()
//                    var pokemons: [Pokemon] = []
//
//                    for result in response.results {
//                        group.enter()
//                        guard let detailURL = URL(string: result.url) else { continue }
//                        URLSession.shared.dataTask(with: detailURL) { detailData, _, _ in
//                            if let detailData = detailData {
//                                if let pokemon = try? decoder.decode(Pokemon.self, from: detailData) {
//                                    pokemons.append(pokemon)
//                                }
//                            }
//                            group.leave()
//                        }.resume()
//                    }
//
//                    group.notify(queue: .main) {
//                        completion(pokemons)
//                    }
//                } catch {
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }.resume()
//    }
//
//    struct PokemonListResponse: Codable {
//        let results: [PokemonListItem]
//    }
//
//    struct PokemonListItem: Codable {
//        let name: String
//        let url: String
//    }
//}
