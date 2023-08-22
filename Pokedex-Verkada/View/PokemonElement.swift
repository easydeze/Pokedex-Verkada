//
//  PokemonElement.swift
//  Pokedex-Verkada
//
//  Created by Danny Zhang on 8/21/23.
//

import SwiftUI

struct PokemonElement: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Bulbasaur")
                    .font(.headline)
                
                HStack {
                    Text("POISON")
                    
                    Image("!")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                }
            }
        }
        .cornerRadius(12)
    }
}

struct PokemonElement_Previews: PreviewProvider {
    static var previews: some View {
        PokemonElement()
    }
}
