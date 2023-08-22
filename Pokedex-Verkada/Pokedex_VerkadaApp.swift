//
//  Pokedex_VerkadaApp.swift
//  Pokedex-Verkada
//
//  Created by Danny Zhang on 8/21/23.
//

import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            PokedexView(viewModel: PokemonViewModel())
        }
    }
}
