struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let sprites: Sprite
}

struct Sprite: Decodable {
    let front_default: String?
}

struct PokemonListItem: Identifiable, Decodable {
    let name: String
    let url: String
    
    var id: String {
        return url
    }
}

struct PokemonList: Decodable {
    let results: [PokemonListItem]
}
