//
//  Manager.swift
//  Pokedex-Verkada
//
//  Created by Danny Zhang on 8/21/23.
//

import Foundation

struct Pokemon : Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry : Codable, Identifiable {
    var id = UUID()
    var name: String
    var url: String
}

class PokemonAPI {
    func getData(completion: @escaping ([PokemonEntry]) -> ()) {
//        guard let url = URL(string : "https://pokeapi.co/api/v2/pokemon?")
    }
}
