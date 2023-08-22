import SwiftUI
import SDWebImageSwiftUI

struct PokedexView: View {
    @ObservedObject var viewModel: PokemonViewModel
    
    // Define the grid layout
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        VStack {
            VStack { // Header
                // Title
                Text("Pokédex")
                    .font(.headline)
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 10)
            }.background(Color.white)
            HStack { // Design elements
                Circle()
                    .foregroundColor(Color.blue)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .frame(width: 50, height: 50)
                    .offset(x: -90.0, y: 20.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                
                Circle()
                    .foregroundColor(Color(hue: 1.0, saturation: 0.845, brightness: 0.482))
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .frame(width: 15, height: 15)
                    .offset(x: -85.0, y: 5.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                
                Circle()
                    .foregroundColor(.yellow)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .frame(width: 15, height: 15)
                    .offset(x: -80.0, y: 4.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                
                Circle()
                    .foregroundColor(.green)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .frame(width: 15, height: 15)
                    .offset(x: -75.0, y: 4.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            }

            // Selected Pokemon Image
            if let selectedPokemon = viewModel.selectedPokemon {
                WebImage(url: URL(string: selectedPokemon.sprites.front_default ?? "")) // Image caching via WebImage
                    .onSuccess { image, data, cacheType in
                    }
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 20)
            } else {
                WebImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/25.gif"))
                    .onSuccess { image, data, cacheType in
                    }
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding([.leading, .bottom], 25.0)
            }
           let gridItemLayout = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]

            // Pokemon Grid
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(viewModel.pokemonList, id: \.name) { pokemonItem in
                        Button(action: {
                            viewModel.fetchPokemonDetails(for: pokemonItem) // Select a pokemon
                        }) {
                            VStack {
                                Image("pokeball")
                                Text(pokemonItem.name.capitalized)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            .padding(.all, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                        .onAppear {
                            viewModel.checkAndLoadMoreData(currPoke: pokemonItem)
                        }
                    }
                }

                .padding(.horizontal, 15)
            }
        }
        .background(Color.red)
        .onAppear {
            viewModel.fetchPokemon()
        }
    }
}
